infert
library(dplyr)
tbl_df(infert)
View(infert)
infert$age %>%
  round(2) %>%
  mean()
mean(round(infert$age, 2))


library(EDAWR)
storms
storms$storm
storms$wind
storms$pressure
storms$date

cases
cases$country
names(cases)[-1]
unlist(cases[1:3, 2:4])

pollution
pollution$city[c(1, 3, 5)]
pollution$amount[c(1, 3, 5)]
pollution$amount[c(2, 4, 6)]

library(tidyr)
gather(cases, "year", "n", 2:4)
gather(cases, "year", "n", 2:4) %>% spread(year, n)

spread(pollution, size, amount)
spread(pollution, size, amount) %>% gather("size", "amount", 2:3)

separate(storms, date, c("year", "month", "day"), sep = "-")
separate(storms, date, c("year", "month", "day"), sep = "-") %>%
  unite("date", day, month, year, sep = "/")


EDAWR::storms
select(EDAWR::storms, storm, pressure)
select(EDAWR::storms, -storm)
select(EDAWR::storms, wind:date)
EDAWR::storms %>% select(contains("ate"))
EDAWR::storms %>% select(ends_with("e"))
EDAWR::storms %>% select(starts_with("s"))

EDAWR::storms %>% filter(pressure > 1005, wind >= 45)
EDAWR::storms %>% filter(pressure > 1005, wind >= 45,
                         storm %in% c("Alberto", "Alex"))
EDAWR::storms %>%
  filter(pressure > 1005, wind >= 45, storm %in% c("Alberto", "Alex")) %>%
  mutate(ratio = pressure/wind)
EDAWR::storms %>%
  filter(pressure > 1005, wind >= 45, storm %in% c("Alberto", "Alex")) %>%
  mutate(ratio = pressure/wind, inverse = ratio^-1)

pollution %>% summarise(median = median(amount), variance = var(amount))
EDAWR::storms %>% arrange(wind)
EDAWR::storms %>% arrange(desc(wind))

pollution %>% group_by(city) %>%
  summarise(mean = mean(amount), sum = sum(amount), n = n())
pollution %>% group_by(size) %>%
  summarise(mean = mean(amount), sum = sum(amount), n = n())

tb
tb %>% group_by(country, sex) %>% summarise(n = n())

y
z
bind_cols(y, z)
bind_rows(y, z)
union(y, z)
intersect(y, z)
setdiff(y, z)

songs
artists
left_join(songs, artists, by = "name")
right_join(songs, artists, by = "name")
inner_join(songs, artists, by = "name")
full_join(songs, artists, by = "name")
semi_join(songs, artists, by = "name")
semi_join(artists, songs, by = "name")
anti_join(songs, artists, by = "name")
anti_join(artists, songs, by = "name")

songs2
artists2
left_join(songs2, artists2, by = c("first", "last"))

