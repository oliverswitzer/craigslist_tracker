defmodule CraigslistTracker do
  def scrape() do
    browser = Playwright.launch(:chromium)
    page = browser |> Playwright.Browser.new_page()

    page
    |> Playwright.Page.goto("https://www.searchcraigslist.net/results?q=motoguzzi%20v7")

    page
    |> Playwright.Page.query_selector_all(".gs-webResult")
    |> Enum.map(fn el ->
      Playwright.ElementHandle.text_content(el)
      |> String.trim()
    end)

    browser
    |> Playwright.Browser.close()
  end
end
