defmodule RegisterRoom.RegistrationTest do
  use RegisterRoom.DataCase

  alias RegisterRoom.Registration

  describe "vouchers" do
    alias RegisterRoom.Registration.Voucher

    @valid_attrs %{due_date: "2010-04-17T14:00:00Z", info: "some info", token: "some token"}
    @update_attrs %{due_date: "2011-05-18T15:01:01Z", info: "some updated info", token: "some updated token"}
    @invalid_attrs %{due_date: nil, info: nil, token: nil}

    def voucher_fixture(attrs \\ %{}) do
      {:ok, voucher} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Registration.create_voucher()

      voucher
    end

    test "list_vouchers/0 returns all vouchers" do
      voucher = voucher_fixture()
      assert Registration.list_vouchers() == [voucher]
    end

    test "get_voucher!/1 returns the voucher with given id" do
      voucher = voucher_fixture()
      assert Registration.get_voucher!(voucher.id) == voucher
    end

    test "create_voucher/1 with valid data creates a voucher" do
      assert {:ok, %Voucher{} = voucher} = Registration.create_voucher(@valid_attrs)
      assert voucher.due_date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert voucher.info == "some info"
      assert voucher.token == "some token"
    end

    test "create_voucher/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Registration.create_voucher(@invalid_attrs)
    end

    test "update_voucher/2 with valid data updates the voucher" do
      voucher = voucher_fixture()
      assert {:ok, %Voucher{} = voucher} = Registration.update_voucher(voucher, @update_attrs)
      assert voucher.due_date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert voucher.info == "some updated info"
      assert voucher.token == "some updated token"
    end

    test "update_voucher/2 with invalid data returns error changeset" do
      voucher = voucher_fixture()
      assert {:error, %Ecto.Changeset{}} = Registration.update_voucher(voucher, @invalid_attrs)
      assert voucher == Registration.get_voucher!(voucher.id)
    end

    test "delete_voucher/1 deletes the voucher" do
      voucher = voucher_fixture()
      assert {:ok, %Voucher{}} = Registration.delete_voucher(voucher)
      assert_raise Ecto.NoResultsError, fn -> Registration.get_voucher!(voucher.id) end
    end

    test "change_voucher/1 returns a voucher changeset" do
      voucher = voucher_fixture()
      assert %Ecto.Changeset{} = Registration.change_voucher(voucher)
    end
  end

  describe "participants" do
    alias RegisterRoom.Registration.Participant

    @valid_attrs %{email: "some email", firm: "some firm", name: "some name", position: "some position", surname: "some surname"}
    @update_attrs %{email: "some updated email", firm: "some updated firm", name: "some updated name", position: "some updated position", surname: "some updated surname"}
    @invalid_attrs %{email: nil, firm: nil, name: nil, position: nil, surname: nil}

    def participant_fixture(attrs \\ %{}) do
      {:ok, participant} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Registration.create_participant()

      participant
    end

    test "list_participants/0 returns all participants" do
      participant = participant_fixture()
      assert Registration.list_participants() == [participant]
    end

    test "get_participant!/1 returns the participant with given id" do
      participant = participant_fixture()
      assert Registration.get_participant!(participant.id) == participant
    end

    test "create_participant/1 with valid data creates a participant" do
      assert {:ok, %Participant{} = participant} = Registration.create_participant(@valid_attrs)
      assert participant.email == "some email"
      assert participant.firm == "some firm"
      assert participant.name == "some name"
      assert participant.position == "some position"
      assert participant.surname == "some surname"
    end

    test "create_participant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Registration.create_participant(@invalid_attrs)
    end

    test "update_participant/2 with valid data updates the participant" do
      participant = participant_fixture()
      assert {:ok, %Participant{} = participant} = Registration.update_participant(participant, @update_attrs)
      assert participant.email == "some updated email"
      assert participant.firm == "some updated firm"
      assert participant.name == "some updated name"
      assert participant.position == "some updated position"
      assert participant.surname == "some updated surname"
    end

    test "update_participant/2 with invalid data returns error changeset" do
      participant = participant_fixture()
      assert {:error, %Ecto.Changeset{}} = Registration.update_participant(participant, @invalid_attrs)
      assert participant == Registration.get_participant!(participant.id)
    end

    test "delete_participant/1 deletes the participant" do
      participant = participant_fixture()
      assert {:ok, %Participant{}} = Registration.delete_participant(participant)
      assert_raise Ecto.NoResultsError, fn -> Registration.get_participant!(participant.id) end
    end

    test "change_participant/1 returns a participant changeset" do
      participant = participant_fixture()
      assert %Ecto.Changeset{} = Registration.change_participant(participant)
    end
  end
end
