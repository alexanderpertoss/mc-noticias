require "application_system_test_case"

class CurrenciesTest < ApplicationSystemTestCase
  setup do
    @currency = currencies(:one)
  end

  test "visiting the index" do
    visit currencies_url
    assert_selector "h1", text: "Currencies"
  end

  test "should create currency" do
    visit currencies_url
    click_on "New currency"

    fill_in "Blue dollar", with: @currency.blue_dollar
    fill_in "Official dolar purchase", with: @currency.official_dolar_purchase
    fill_in "Official dolar sell", with: @currency.official_dolar_sell
    click_on "Create Currency"

    assert_text "Currency was successfully created"
    click_on "Back"
  end

  test "should update Currency" do
    visit currency_url(@currency)
    click_on "Edit this currency", match: :first

    fill_in "Blue dollar", with: @currency.blue_dollar
    fill_in "Official dolar purchase", with: @currency.official_dolar_purchase
    fill_in "Official dolar sell", with: @currency.official_dolar_sell
    click_on "Update Currency"

    assert_text "Currency was successfully updated"
    click_on "Back"
  end

  test "should destroy Currency" do
    visit currency_url(@currency)
    click_on "Destroy this currency", match: :first

    assert_text "Currency was successfully destroyed"
  end
end
