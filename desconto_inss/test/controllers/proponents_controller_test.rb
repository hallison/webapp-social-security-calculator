require "test_helper"

class ProponentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @proponent = proponents(:one)
  end

  test "should get index" do
    get proponents_url
    assert_response :success
  end

  test "should get new" do
    get new_proponent_url
    assert_response :success
  end

  test "should create proponent" do
    assert_difference("Proponent.count") do
      post proponents_url, params: {
        proponent: {
          name: "Elektra Natchios",
          document_br_cpf: "12323434567",
          birth_date: "1980-11-14",
          address_public_place: @proponent.address_public_place,
          address_number: @proponent.address_number,
          address_district: @proponent.address_district,
          address_city: @proponent.address_city,
          address_state: @proponent.address_state,
          address_postalcode: @proponent.address_postalcode,
          phone_contact: @proponent.phone_contact,
          phone_reference: @proponent.phone_reference,
          salary_gross: @proponent.salary_gross,
        }
      }
    end

    assert_redirected_to proponent_url(Proponent.last)
  end

  test "should show proponent" do
    get proponents_url(@proponent)
    assert_response :success
  end

  test "should edit proponent" do
    get edit_proponent_url(@proponent)
    assert_response :success
  end

  test "should update proponent" do
    put proponent_url(@proponent), params: {
      proponent: {
        salary_gross: 900000,
      }
    }

    assert_redirected_to proponent_url(@proponent)
  end

  test "should destroy proponent" do
    assert_difference("Proponent.count", -1) do
      delete proponent_url(@proponent)
    end

    assert_redirected_to proponents_url, status: :see_other
  end

  test "should update proponent's salary" do
    assert_changes("@proponent.salary_net") do
      put update_salary_proponent_url(@proponent)
    end

    assert_redirected_to proponent_url(@proponent)
  end
end
