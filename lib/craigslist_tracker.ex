defmodule CraigslistTracker do
  def scrape(search_query) do
    browser = Playwright.launch(:chromium)
    page = browser |> Playwright.Browser.new_page()

    page
    |> Playwright.Page.goto(
      "https://www.searchcraigslist.net/results?#{URI.encode_query(%{q: search_query})}"
      |> IO.inspect()
    )

    listings =
      page
      |> Playwright.Page.query_selector_all(".gs-webResult")

    listings
    |> Enum.map(fn el ->
      Playwright.ElementHandle.text_content(el)
      |> String.trim()
    end)

    link =
      listings
      |> List.first()
      |> Playwright.ElementHandle.query_selector("a.gs-title")
      |> Playwright.ElementHandle.get_attribute("href")
      |> IO.inspect(label: "link")

    Playwright.Page.goto(page, link)

    page
    |> Playwright.Page.wait_for_selector(".posting")

    locator =
      page
      |> Playwright.Locator.new(".postingtitletext")

    if Playwright.Locator.count(locator) > 0 do
      IO.puts("this is a parseable ad")
      Playwright.Locator.text_content(locator)
    else
      page_text =
        page
        |> Playwright.Page.text_content("body")

      if String.contains?(page_text, "This posting has been deleted") do
        IO.puts("posting was deleted by user")
      else
        IO.puts("this is not a parseable ad")
      end
    end

    # |> Playwright.ElementHandle.text_content()
    # |> IO.inspect(label: "body")

    browser
    |> Playwright.Browser.close()
  end
end
