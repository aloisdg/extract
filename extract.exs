data_alois = %{
  name: "Aloïs de Gouvello",
  titles: ["software developer", "speaker", "open source contributor"],
  pronouns: "he/his/him",
  mail: "alois@outlook.fr",
  phone: "+3361234567",
  origin: %{city: "Paris", country: "France"},
  locality: %{city: "Paris", country: "France"},
  networks: %{
    twitter: "https://twitter.com/aloisdg",
    github: "https://github.com/aloisdg",
    gitlab: "https://gitlab.com/aloisdg",
    stackoverflow: "https://stackoverflow.com/users/1248177/aloisdg",
    linkedin: "https://www.linkedin.com/in/aloisdg"
  }
}

data = %{
  name: "Kim Clarisse",
  titles: ["QA Tester Junior"],
  pronouns: "she/her/her",
  mail: "kim.clarisse@pm.me",
  phone: "+3361234567",
  origin: %{city: "Paris", country: "France"},
  locality: %{city: "Paris", country: "France"},
  networks: %{
    github: "https://github.com/kimclarisse",
    linkedin: "https://www.linkedin.com/in/kimclarisse"
  }
}

network_icons = %{
  twitter: "fa-twitter",
  github: "fa-github",
  gitlab: "fa-gitlab",
  stackoverflow: "fa-stack-overflow",
  linkedin: "fa-linkedin-square",
  facebook: "fa-facebook-official",
  youtube: "fa-youtube-play"
}

add_locality = fn data ->
  if !Map.has_key?(data, :origin) || data.origin == data.locality,
    do: "I live in #{data.locality.city}, #{data.locality.country}.",
    else:
      "I'm from #{data.origin.city}, #{data.origin.country} and currently live in #{
        data.locality.city
      }, #{data.locality.country}."
end

humanize_list = fn l -> "#{l |> Enum.drop(-1) |> Enum.join(", ")} and #{List.last(l)}" end

add_pronouns = fn data ->
  if Map.has_key?(data, :pronouns), do: "My pronouns are #{data.pronouns}.", else: ""
end

add_phone = fn data ->
  if Map.has_key?(data, :phone), do: "or <a href=\"tel:#{data.phone}\">call me</a>", else: ""
end

add_titles = fn data ->
  if length(data.titles) > 1, do: humanize_list.(data.titles), else: data.titles |> Enum.at(0)
end

add_network_icon = fn key ->
  if Map.has_key?(network_icons, key), do: network_icons[key], else: "fa-link"
end

add_network = fn key, value ->
  "<li><a href=\"#{value}\" title=\"#{key}\"><i class=\"fa #{add_network_icon.(key)}\" aria-hidden=\"true\"></i></a></li>"
end

add_networks = fn l ->
  l |> Enum.map(fn {key, value} -> add_network.(key, value) end) |> Enum.join("\n  ")
end

template = """
<section>
  I'm <b>#{data.name}</b>, a #{add_titles.(data)}. #{add_pronouns.(data)}
  <br>
  #{add_locality.(data)}
  <br>
  <a href="mailto:#{data.mail}">Say hi</a> #{add_phone.(data)}.
</section>
<ul>
  <li></li>
  #{add_networks.(data.networks)}
  <li></li>
</ul>
"""

IO.puts(template)
