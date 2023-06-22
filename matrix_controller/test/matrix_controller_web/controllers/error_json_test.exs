defmodule MatrixControllerWeb.ErrorJSONTest do
  use MatrixControllerWeb.ConnCase, async: true

  test "renders 404" do
    assert MatrixControllerWeb.ErrorJSON.render("404.json", %{}) == %{
             errors: %{detail: "Not Found"}
           }
  end

  test "renders 500" do
    assert MatrixControllerWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
