Working with tidyr Package
--------------------------

In this first section I tried to use `gather()` and `spread()` function
from `tidyr` package in order to convert the structure of a data frame
to be more tidy. I use three data frames from `EDAWR` package which are
`storm`, `cases`, and `pollution` .

``` r
library(EDAWR)
storms
```

    ##     storm wind pressure       date
    ## 1 Alberto  110     1007 2000-08-03
    ## 2    Alex   45     1009 1998-07-27
    ## 3 Allison   65     1005 1995-06-03
    ## 4     Ana   40     1013 1997-06-30
    ## 5  Arlene   50     1010 1999-06-11
    ## 6  Arthur   45     1010 1996-06-17

``` r
storms$storm
```

    ## [1] "Alberto" "Alex"    "Allison" "Ana"     "Arlene"  "Arthur"

``` r
storms$wind
```

    ## [1] 110  45  65  40  50  45

``` r
storms$pressure
```

    ## [1] 1007 1009 1005 1013 1010 1010

``` r
storms$date
```

    ## [1] "2000-08-03" "1998-07-27" "1995-06-03" "1997-06-30" "1999-06-11"
    ## [6] "1996-06-17"

``` r
cases
```

    ##   country  2011  2012  2013
    ## 1      FR  7000  6900  7000
    ## 2      DE  5800  6000  6200
    ## 3      US 15000 14000 13000

``` r
cases$country
```

    ## [1] "FR" "DE" "US"

``` r
names(cases)[-1]
```

    ## [1] "2011" "2012" "2013"

``` r
unlist(cases[1:3, 2:4])
```

    ## 20111 20112 20113 20121 20122 20123 20131 20132 20133 
    ##  7000  5800 15000  6900  6000 14000  7000  6200 13000

``` r
pollution
```

    ##       city  size amount
    ## 1 New York large     23
    ## 2 New York small     14
    ## 3   London large     22
    ## 4   London small     16
    ## 5  Beijing large    121
    ## 6  Beijing small     56

``` r
pollution$city[c(1, 3, 5)]
```

    ## [1] "New York" "London"   "Beijing"

``` r
pollution$amount[c(1, 3, 5)]
```

    ## [1]  23  22 121

``` r
pollution$amount[c(2, 4, 6)]
```

    ## [1] 14 16 56

``` r
library(tidyr)
```

    ## 
    ## Attaching package: 'tidyr'

    ## The following objects are masked from 'package:EDAWR':
    ## 
    ##     population, who

``` r
gather(cases, "year", "n", 2:4)
```

    ##   country year     n
    ## 1      FR 2011  7000
    ## 2      DE 2011  5800
    ## 3      US 2011 15000
    ## 4      FR 2012  6900
    ## 5      DE 2012  6000
    ## 6      US 2012 14000
    ## 7      FR 2013  7000
    ## 8      DE 2013  6200
    ## 9      US 2013 13000

``` r
gather(cases, "year", "n", 2:4) %>% spread(year, n)
```

    ##   country  2011  2012  2013
    ## 1      DE  5800  6000  6200
    ## 2      FR  7000  6900  7000
    ## 3      US 15000 14000 13000

``` r
spread(pollution, size, amount)
```

    ##       city large small
    ## 1  Beijing   121    56
    ## 2   London    22    16
    ## 3 New York    23    14

``` r
spread(pollution, size, amount) %>% gather("size", "amount", 2:3)
```

    ##       city  size amount
    ## 1  Beijing large    121
    ## 2   London large     22
    ## 3 New York large     23
    ## 4  Beijing small     56
    ## 5   London small     16
    ## 6 New York small     14

Another functions in `tidyr` package that would be useful are
`separate()` and `unite()` to modify the structure of value on a
varibel. Below are two examples on how to use these functions.

``` r
separate(storms, date, c("year", "month", "day"), sep = "-")
```

    ## # A tibble: 6 x 6
    ##   storm    wind pressure year  month day  
    ##   <chr>   <int>    <int> <chr> <chr> <chr>
    ## 1 Alberto   110     1007 2000  08    03   
    ## 2 Alex       45     1009 1998  07    27   
    ## 3 Allison    65     1005 1995  06    03   
    ## 4 Ana        40     1013 1997  06    30   
    ## 5 Arlene     50     1010 1999  06    11   
    ## 6 Arthur     45     1010 1996  06    17

``` r
separate(storms, date, c("year", "month", "day"), sep = "-") %>%
  unite("date", day, month, year, sep = "/")
```

    ## # A tibble: 6 x 4
    ##   storm    wind pressure date      
    ##   <chr>   <int>    <int> <chr>     
    ## 1 Alberto   110     1007 03/08/2000
    ## 2 Alex       45     1009 27/07/1998
    ## 3 Allison    65     1005 03/06/1995
    ## 4 Ana        40     1013 30/06/1997
    ## 5 Arlene     50     1010 11/06/1999
    ## 6 Arthur     45     1010 17/06/1996

Working with dplyr Package
--------------------------

`dplyr` is a powerful package for doing data wrangling in R, it contains
many functions that are useful for R user to manipulate the dataset such
are `select()` for selecting any variabel and `filter()` for filtering
any value in some conditions, and many others. Examples on how to use
these functions can be seen below.

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following object is masked from 'package:EDAWR':
    ## 
    ##     storms

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
EDAWR::storms
```

    ##     storm wind pressure       date
    ## 1 Alberto  110     1007 2000-08-03
    ## 2    Alex   45     1009 1998-07-27
    ## 3 Allison   65     1005 1995-06-03
    ## 4     Ana   40     1013 1997-06-30
    ## 5  Arlene   50     1010 1999-06-11
    ## 6  Arthur   45     1010 1996-06-17

``` r
select(EDAWR::storms, storm, pressure)
```

    ##     storm pressure
    ## 1 Alberto     1007
    ## 2    Alex     1009
    ## 3 Allison     1005
    ## 4     Ana     1013
    ## 5  Arlene     1010
    ## 6  Arthur     1010

``` r
select(EDAWR::storms, -storm)
```

    ##   wind pressure       date
    ## 1  110     1007 2000-08-03
    ## 2   45     1009 1998-07-27
    ## 3   65     1005 1995-06-03
    ## 4   40     1013 1997-06-30
    ## 5   50     1010 1999-06-11
    ## 6   45     1010 1996-06-17

``` r
select(EDAWR::storms, wind:date)
```

    ##   wind pressure       date
    ## 1  110     1007 2000-08-03
    ## 2   45     1009 1998-07-27
    ## 3   65     1005 1995-06-03
    ## 4   40     1013 1997-06-30
    ## 5   50     1010 1999-06-11
    ## 6   45     1010 1996-06-17

``` r
EDAWR::storms %>% select(contains("ate"))
```

    ##         date
    ## 1 2000-08-03
    ## 2 1998-07-27
    ## 3 1995-06-03
    ## 4 1997-06-30
    ## 5 1999-06-11
    ## 6 1996-06-17

``` r
EDAWR::storms %>% select(ends_with("e"))
```

    ##   pressure       date
    ## 1     1007 2000-08-03
    ## 2     1009 1998-07-27
    ## 3     1005 1995-06-03
    ## 4     1013 1997-06-30
    ## 5     1010 1999-06-11
    ## 6     1010 1996-06-17

``` r
EDAWR::storms %>% select(starts_with("s"))
```

    ##     storm
    ## 1 Alberto
    ## 2    Alex
    ## 3 Allison
    ## 4     Ana
    ## 5  Arlene
    ## 6  Arthur

``` r
EDAWR::storms %>% filter(pressure > 1005, wind >= 45)
```

    ##     storm wind pressure       date
    ## 1 Alberto  110     1007 2000-08-03
    ## 2    Alex   45     1009 1998-07-27
    ## 3  Arlene   50     1010 1999-06-11
    ## 4  Arthur   45     1010 1996-06-17

``` r
EDAWR::storms %>% filter(pressure > 1005, wind >= 45,
                         storm %in% c("Alberto", "Alex"))
```

    ##     storm wind pressure       date
    ## 1 Alberto  110     1007 2000-08-03
    ## 2    Alex   45     1009 1998-07-27

``` r
EDAWR::storms %>%
  filter(pressure > 1005, wind >= 45, storm %in% c("Alberto", "Alex")) %>%
  mutate(ratio = pressure/wind)
```

    ##     storm wind pressure       date     ratio
    ## 1 Alberto  110     1007 2000-08-03  9.154545
    ## 2    Alex   45     1009 1998-07-27 22.422222

``` r
EDAWR::storms %>%
  filter(pressure > 1005, wind >= 45, storm %in% c("Alberto", "Alex")) %>%
  mutate(ratio = pressure/wind, inverse = ratio^-1)
```

    ##     storm wind pressure       date     ratio    inverse
    ## 1 Alberto  110     1007 2000-08-03  9.154545 0.10923535
    ## 2    Alex   45     1009 1998-07-27 22.422222 0.04459861

``` r
pollution %>% summarise(median = median(amount), variance = var(amount))
```

    ##   median variance
    ## 1   22.5   1731.6

``` r
EDAWR::storms %>% arrange(wind)
```

    ##     storm wind pressure       date
    ## 1     Ana   40     1013 1997-06-30
    ## 2    Alex   45     1009 1998-07-27
    ## 3  Arthur   45     1010 1996-06-17
    ## 4  Arlene   50     1010 1999-06-11
    ## 5 Allison   65     1005 1995-06-03
    ## 6 Alberto  110     1007 2000-08-03

``` r
EDAWR::storms %>% arrange(desc(wind))
```

    ##     storm wind pressure       date
    ## 1 Alberto  110     1007 2000-08-03
    ## 2 Allison   65     1005 1995-06-03
    ## 3  Arlene   50     1010 1999-06-11
    ## 4    Alex   45     1009 1998-07-27
    ## 5  Arthur   45     1010 1996-06-17
    ## 6     Ana   40     1013 1997-06-30

``` r
pollution %>% group_by(city) %>%
  summarise(mean = mean(amount), sum = sum(amount), n = n())
```

    ## # A tibble: 3 x 4
    ##   city      mean   sum     n
    ##   <chr>    <dbl> <dbl> <int>
    ## 1 Beijing   88.5   177     2
    ## 2 London    19      38     2
    ## 3 New York  18.5    37     2

``` r
pollution %>% group_by(size) %>%
  summarise(mean = mean(amount), sum = sum(amount), n = n())
```

    ## # A tibble: 2 x 4
    ##   size   mean   sum     n
    ##   <chr> <dbl> <dbl> <int>
    ## 1 large  55.3   166     3
    ## 2 small  28.7    86     3

``` r
tb
```

    ## # A tibble: 3,800 x 6
    ##    country      year sex    child adult elderly
    ##  * <chr>       <int> <chr>  <int> <int>   <int>
    ##  1 Afghanistan  1995 female    NA    NA      NA
    ##  2 Afghanistan  1995 male      NA    NA      NA
    ##  3 Afghanistan  1996 female    NA    NA      NA
    ##  4 Afghanistan  1996 male      NA    NA      NA
    ##  5 Afghanistan  1997 female     5    96       1
    ##  6 Afghanistan  1997 male       0    26       0
    ##  7 Afghanistan  1998 female    45  1142      20
    ##  8 Afghanistan  1998 male      30   500      41
    ##  9 Afghanistan  1999 female    25   484       8
    ## 10 Afghanistan  1999 male       8   212       8
    ## # ... with 3,790 more rows

``` r
tb %>% group_by(country, sex) %>% summarise(n = n())
```

    ## # A tibble: 200 x 3
    ## # Groups:   country [100]
    ##    country     sex        n
    ##    <chr>       <chr>  <int>
    ##  1 Afghanistan female    19
    ##  2 Afghanistan male      19
    ##  3 Algeria     female    19
    ##  4 Algeria     male      19
    ##  5 Angola      female    19
    ##  6 Angola      male      19
    ##  7 Argentina   female    19
    ##  8 Argentina   male      19
    ##  9 Azerbaijan  female    19
    ## 10 Azerbaijan  male      19
    ## # ... with 190 more rows

With `dplyr` package we can also join two table with many functions such
are `right_join()`, `left_join()`, `full_join()`, and many others. Here
are some examples on how to join tables with `dplyr`.

``` r
y
```

    ##   x1 x2
    ## 1  A  1
    ## 2  B  2
    ## 3  C  3

``` r
z
```

    ##   x1 x2
    ## 1  B  2
    ## 2  C  3
    ## 3  D  4

``` r
bind_cols(y, z)
```

    ##   x1 x2 x11 x21
    ## 1  A  1   B   2
    ## 2  B  2   C   3
    ## 3  C  3   D   4

``` r
bind_rows(y, z)
```

    ##   x1 x2
    ## 1  A  1
    ## 2  B  2
    ## 3  C  3
    ## 4  B  2
    ## 5  C  3
    ## 6  D  4

``` r
union(y, z)
```

    ##   x1 x2
    ## 1  A  1
    ## 2  B  2
    ## 3  C  3
    ## 4  D  4

``` r
intersect(y, z)
```

    ##   x1 x2
    ## 1  B  2
    ## 2  C  3

``` r
setdiff(y, z)
```

    ##   x1 x2
    ## 1  A  1

``` r
songs
```

    ##                  song  name
    ## 1 Across the Universe  John
    ## 2       Come Together  John
    ## 3      Hello, Goodbye  Paul
    ## 4           Peggy Sue Buddy

``` r
artists
```

    ##     name  plays
    ## 1 George  sitar
    ## 2   John guitar
    ## 3   Paul   bass
    ## 4  Ringo  drums

``` r
left_join(songs, artists, by = "name")
```

    ##                  song  name  plays
    ## 1 Across the Universe  John guitar
    ## 2       Come Together  John guitar
    ## 3      Hello, Goodbye  Paul   bass
    ## 4           Peggy Sue Buddy   <NA>

``` r
right_join(songs, artists, by = "name")
```

    ##                  song   name  plays
    ## 1                <NA> George  sitar
    ## 2 Across the Universe   John guitar
    ## 3       Come Together   John guitar
    ## 4      Hello, Goodbye   Paul   bass
    ## 5                <NA>  Ringo  drums

``` r
inner_join(songs, artists, by = "name")
```

    ##                  song name  plays
    ## 1 Across the Universe John guitar
    ## 2       Come Together John guitar
    ## 3      Hello, Goodbye Paul   bass

``` r
full_join(songs, artists, by = "name")
```

    ##                  song   name  plays
    ## 1 Across the Universe   John guitar
    ## 2       Come Together   John guitar
    ## 3      Hello, Goodbye   Paul   bass
    ## 4           Peggy Sue  Buddy   <NA>
    ## 5                <NA> George  sitar
    ## 6                <NA>  Ringo  drums

``` r
semi_join(songs, artists, by = "name")
```

    ##                  song name
    ## 1 Across the Universe John
    ## 2       Come Together John
    ## 3      Hello, Goodbye Paul

``` r
semi_join(artists, songs, by = "name")
```

    ##   name  plays
    ## 1 John guitar
    ## 2 Paul   bass

``` r
anti_join(songs, artists, by = "name")
```

    ##        song  name
    ## 1 Peggy Sue Buddy

``` r
anti_join(artists, songs, by = "name")
```

    ##     name plays
    ## 1 George sitar
    ## 2  Ringo drums

``` r
songs2
```

    ##                  song first      last
    ## 1 Across the Universe  John    Lennon
    ## 2       Come Together  John    Lennon
    ## 3      Hello, Goodbye  Paul McCartney
    ## 4           Peggy Sue Buddy     Holly

``` r
artists2
```

    ##    first      last  plays
    ## 1 George  Harrison  sitar
    ## 2   John    Lennon guitar
    ## 3   Paul McCartney   bass
    ## 4  Ringo     Starr  drums
    ## 5   Paul     Simon guitar
    ## 6   John  Coltrane    sax

``` r
left_join(songs2, artists2, by = c("first", "last"))
```

    ##                  song first      last  plays
    ## 1 Across the Universe  John    Lennon guitar
    ## 2       Come Together  John    Lennon guitar
    ## 3      Hello, Goodbye  Paul McCartney   bass
    ## 4           Peggy Sue Buddy     Holly   <NA>
