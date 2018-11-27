defmodule MoviedbWeb.Schema do
  use Absinthe.Schema

  @movies %{
    "1" => %{title: "Kill Bill", author_id: "1"},
    "2" => %{title: "The Great Gatsby", author_id: "2"},
    "3" => %{title: "True Romance", author_id: "1"}
  }

  @authors %{
    "1" => %{first_name: "Quentin", last_name: "Tarantino"},
    "2" => %{first_name: "Baz", last_name: "Luhrmann"}
  }

  @desc "An Author"
  object :author do
    @desc "The Authors's first name"
    field :first_name, :string do
      resolve(fn %{first_name: first_name}, _, _ ->
        {:ok, first_name}
      end)
    end

    @desc "The Authors's last name"
    field :last_name, :string do
      resolve(fn %{last_name: last_name}, _, _ ->
        {:ok, last_name}
      end)
    end
  end

  @desc "A Movie"
  object :movie do
    @desc "The Movie's title at release time"
    field :title, :string do
      resolve(fn %{title: title}, _, _ ->
        {:ok, title}
      end)
    end

    @desc "The Movie's author"
    field :author, :author do
      resolve(fn %{author_id: id}, _, _ ->
        author =
          @authors
          |> Map.fetch(id)
          |> case do
            :error ->
              {:error, "Author not found"}

            {:ok, author} ->
              {:ok, author}
          end
      end)
    end
  end

  query do
    @desc "Find a movie by its ID"
    field :movie, :movie do
      arg(:id, non_null(:id))

      resolve(fn %{id: id}, _ ->
        @movies
        |> Map.fetch(id)
        |> case do
          :error ->
            {:error, "Movie not found"}

          {:ok, movie} ->
            {:ok, movie}
        end
      end)
    end
  end
end
