defmodule PortalTest do
  use ExUnit.Case
  doctest Portal

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "transferring through the portal" do

    Portal.Door.start_link(:orange)
    Portal.Door.start_link(:blue)
    portal = Portal.transfer(:orange, :blue, [1,2,3])
    Portal.Door.get(:orange)

    Portal.push_right(portal)

    assert Portal.Door.get(:orange) == [2, 1]
    assert Portal.Door.get(:blue) == [3]

  end

  @doc """
  Manages portals with a supervisor defined in Portal.
  Uses shoot(`color`) to start_link supervised.
  """
  test "stopping a door with supervision" do

    Portal.shoot(:orange)
    Portal.shoot(:blue)

    portal = Portal.transfer(:orange, :blue, [1,2,3])
    Portal.push_right(portal)


    # stop the :blue process
    Process.unlink(Process.whereis(:blue))
    Process.exit(Process.whereis(:blue), :shutdown)

    Portal.push_right(portal)

  end

end
