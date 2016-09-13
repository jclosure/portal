# Portal

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `portal` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:portal, "~> 0.1.0"}]
    end
    ```

  2. Ensure `portal` is started before your application:

    ```elixir
    def application do
      [applications: [:portal]]
    end
    ```

## Usage

### Beaming between 2 supervised processes

  1. Host1:

    ```sh
    iex -sname room1 --cookie secret -S mix
    ```

    ```elixir
    Portal.shoot(:blue)
    Portal.Door.get(:blue)
    ```

    ```elixir
    def application do
      [applications: [:portal]]
    end
    ```

  2. Host2:

    ```sh
    iex -sname room2 --cookie secret -S mix
    ```

    ```elixir
    Portal.shoot(:orange)
    Portal.Door.get(:orange)
    blue = {:blue, :"room1@joelholder"}
    orange = {:orange, :"room2@joelholder"}
    portal = Portal.transfer(blue, orange, [1,2,3,4])
    Portal.Door.get(:orange)
    ```

  3. Host1:

    ```elixir
    Portal.Door.get(:blue)
    ```
