defmodule RegisterRoomWeb.ParticipantView do
  use RegisterRoomWeb, :view

  alias RegisterRoom.Registration.{Voucher, Participant}

  def voucher_info(%Participant{voucher: %Voucher{info: info}}), do: info

  def voucher_info(_), do: "---"
end
