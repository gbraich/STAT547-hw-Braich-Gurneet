---
output:
  html_document:
    keep_md: yes
---
LOTR R Markdown file
========================================================

This R Markdown file presents the original data, the statistical summaries and all figures generated.

# Data Tidying and Preliminary Analysis

Load libraries


```r
library(ggplot2)
library(dplyr)
```

```
## Warning: package 'dplyr' was built under R version 3.4.2
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(stringr)
```

Import data


```r
lotr_data <- read.delim("lotr_raw.tsv")
glimpse(lotr_data)
```

```
## Observations: 731
## Variables: 5
## $ Film      <fctr> The Fellowship Of The Ring, The Fellowship Of The R...
## $ Chapter   <fctr> 01: Prologue, 01: Prologue, 01: Prologue, 01: Prolo...
## $ Character <fctr> Bilbo, Elrond, Galadriel, Gollum, Bilbo, Bilbo, Fro...
## $ Race      <fctr> Hobbit, Elf, Elf, Gollum, Hobbit, Hobbit, Hobbit, A...
## $ Words     <int> 4, 5, 460, 20, 214, 70, 128, 197, 10, 12, 339, 64, 8...
```

Make Chapter column into two columns (number and name) and rename columns after binding together


```r
lotr_data_split <- data.frame(do.call(rbind, strsplit(as.vector(lotr_data$Chapter), split = ":")))
names(lotr_data_split) <- c("Chapter_Number", "Chapter_Name")
lotr_data_clean_split <- cbind(lotr_data$Film, lotr_data_split, lotr_data$Character, lotr_data$Race, lotr_data$Words)
ldcs2<- plyr::rename(lotr_data_clean_split, c("lotr_data$Film"="Film", "lotr_data$Character"="Character", "lotr_data$Race"="Race", "lotr_data$Words"="Words"))
ldcs2
```

```
##                           Film Chapter_Number
## 1   The Fellowship Of The Ring             01
## 2   The Fellowship Of The Ring             01
## 3   The Fellowship Of The Ring             01
## 4   The Fellowship Of The Ring             01
## 5   The Fellowship Of The Ring             02
## 6   The Fellowship Of The Ring             03
## 7   The Fellowship Of The Ring             03
## 8   The Fellowship Of The Ring             03
## 9   The Fellowship Of The Ring             03
## 10  The Fellowship Of The Ring             03
## 11  The Fellowship Of The Ring             04
## 12  The Fellowship Of The Ring             04
## 13  The Fellowship Of The Ring             04
## 14  The Fellowship Of The Ring             05
## 15  The Fellowship Of The Ring             05
## 16  The Fellowship Of The Ring             05
## 17  The Fellowship Of The Ring             05
## 18  The Fellowship Of The Ring             05
## 19  The Fellowship Of The Ring             05
## 20  The Fellowship Of The Ring             05
## 21  The Fellowship Of The Ring             05
## 22  The Fellowship Of The Ring             05
## 23  The Fellowship Of The Ring             05
## 24  The Fellowship Of The Ring             06
## 25  The Fellowship Of The Ring             06
## 26  The Fellowship Of The Ring             07
## 27  The Fellowship Of The Ring             07
## 28  The Fellowship Of The Ring             07
## 29  The Fellowship Of The Ring             08
## 30  The Fellowship Of The Ring             08
## 31  The Fellowship Of The Ring             08
## 32  The Fellowship Of The Ring             08
## 33  The Fellowship Of The Ring             09
## 34  The Fellowship Of The Ring             09
## 35  The Fellowship Of The Ring             09
## 36  The Fellowship Of The Ring             09
## 37  The Fellowship Of The Ring             09
## 38  The Fellowship Of The Ring             09
## 39  The Fellowship Of The Ring             09
## 40  The Fellowship Of The Ring             09
## 41  The Fellowship Of The Ring             09
## 42  The Fellowship Of The Ring             10
## 43  The Fellowship Of The Ring             10
## 44  The Fellowship Of The Ring             10
## 45  The Fellowship Of The Ring             10
## 46  The Fellowship Of The Ring             10
## 47  The Fellowship Of The Ring             10
## 48  The Fellowship Of The Ring             11
## 49  The Fellowship Of The Ring             11
## 50  The Fellowship Of The Ring             12
## 51  The Fellowship Of The Ring             12
## 52  The Fellowship Of The Ring             13
## 53  The Fellowship Of The Ring             13
## 54  The Fellowship Of The Ring             13
## 55  The Fellowship Of The Ring             13
## 56  The Fellowship Of The Ring             13
## 57  The Fellowship Of The Ring             14
## 58  The Fellowship Of The Ring             14
## 59  The Fellowship Of The Ring             14
## 60  The Fellowship Of The Ring             14
## 61  The Fellowship Of The Ring             15
## 62  The Fellowship Of The Ring             15
## 63  The Fellowship Of The Ring             15
## 64  The Fellowship Of The Ring             15
## 65  The Fellowship Of The Ring             15
## 66  The Fellowship Of The Ring             15
## 67  The Fellowship Of The Ring             15
## 68  The Fellowship Of The Ring             15
## 69  The Fellowship Of The Ring             15
## 70  The Fellowship Of The Ring             16
## 71  The Fellowship Of The Ring             16
## 72  The Fellowship Of The Ring             16
## 73  The Fellowship Of The Ring             16
## 74  The Fellowship Of The Ring             16
## 75  The Fellowship Of The Ring             17
## 76  The Fellowship Of The Ring             17
## 77  The Fellowship Of The Ring             17
## 78  The Fellowship Of The Ring             18
## 79  The Fellowship Of The Ring             18
## 80  The Fellowship Of The Ring             18
## 81  The Fellowship Of The Ring             19
## 82  The Fellowship Of The Ring             19
## 83  The Fellowship Of The Ring             19
## 84  The Fellowship Of The Ring             19
## 85  The Fellowship Of The Ring             19
## 86  The Fellowship Of The Ring             20
## 87  The Fellowship Of The Ring             21
## 88  The Fellowship Of The Ring             21
## 89  The Fellowship Of The Ring             21
## 90  The Fellowship Of The Ring             21
## 91  The Fellowship Of The Ring             21
## 92  The Fellowship Of The Ring             21
## 93  The Fellowship Of The Ring             22
## 94  The Fellowship Of The Ring             23
## 95  The Fellowship Of The Ring             23
## 96  The Fellowship Of The Ring             23
## 97  The Fellowship Of The Ring             23
## 98  The Fellowship Of The Ring             23
## 99  The Fellowship Of The Ring             23
## 100 The Fellowship Of The Ring             24
## 101 The Fellowship Of The Ring             24
## 102 The Fellowship Of The Ring             24
## 103 The Fellowship Of The Ring             25
## 104 The Fellowship Of The Ring             25
## 105 The Fellowship Of The Ring             25
## 106 The Fellowship Of The Ring             26
## 107 The Fellowship Of The Ring             26
## 108 The Fellowship Of The Ring             27
## 109 The Fellowship Of The Ring             27
## 110 The Fellowship Of The Ring             27
## 111 The Fellowship Of The Ring             27
## 112 The Fellowship Of The Ring             27
## 113 The Fellowship Of The Ring             27
## 114 The Fellowship Of The Ring             27
## 115 The Fellowship Of The Ring             27
## 116 The Fellowship Of The Ring             27
## 117 The Fellowship Of The Ring             27
## 118 The Fellowship Of The Ring             27
## 119 The Fellowship Of The Ring             27
## 120 The Fellowship Of The Ring             28
## 121 The Fellowship Of The Ring             28
## 122 The Fellowship Of The Ring             29
## 123 The Fellowship Of The Ring             29
## 124 The Fellowship Of The Ring             30
## 125 The Fellowship Of The Ring             30
## 126 The Fellowship Of The Ring             30
## 127 The Fellowship Of The Ring             31
## 128 The Fellowship Of The Ring             31
## 129 The Fellowship Of The Ring             31
## 130 The Fellowship Of The Ring             31
## 131 The Fellowship Of The Ring             31
## 132 The Fellowship Of The Ring             31
## 133 The Fellowship Of The Ring             31
## 134 The Fellowship Of The Ring             31
## 135 The Fellowship Of The Ring             32
## 136 The Fellowship Of The Ring             32
## 137 The Fellowship Of The Ring             32
## 138 The Fellowship Of The Ring             32
## 139 The Fellowship Of The Ring             32
## 140 The Fellowship Of The Ring             32
## 141 The Fellowship Of The Ring             32
## 142 The Fellowship Of The Ring             33
## 143 The Fellowship Of The Ring             33
## 144 The Fellowship Of The Ring             33
## 145 The Fellowship Of The Ring             33
## 146 The Fellowship Of The Ring             33
## 147 The Fellowship Of The Ring             33
## 148 The Fellowship Of The Ring             33
## 149 The Fellowship Of The Ring             33
## 150 The Fellowship Of The Ring             33
## 151 The Fellowship Of The Ring             34
## 152 The Fellowship Of The Ring             34
## 153 The Fellowship Of The Ring             34
## 154 The Fellowship Of The Ring             34
## 155 The Fellowship Of The Ring             34
## 156 The Fellowship Of The Ring             34
## 157 The Fellowship Of The Ring             35
## 158 The Fellowship Of The Ring             35
## 159 The Fellowship Of The Ring             35
## 160 The Fellowship Of The Ring             35
## 161 The Fellowship Of The Ring             35
## 162 The Fellowship Of The Ring             35
## 163 The Fellowship Of The Ring             35
## 164 The Fellowship Of The Ring             36
## 165 The Fellowship Of The Ring             36
## 166 The Fellowship Of The Ring             36
## 167 The Fellowship Of The Ring             36
## 168 The Fellowship Of The Ring             36
## 169 The Fellowship Of The Ring             36
## 170 The Fellowship Of The Ring             37
## 171 The Fellowship Of The Ring             37
## 172 The Fellowship Of The Ring             37
## 173 The Fellowship Of The Ring             37
## 174 The Fellowship Of The Ring             37
## 175 The Fellowship Of The Ring             37
## 176 The Fellowship Of The Ring             37
## 177 The Fellowship Of The Ring             38
## 178 The Fellowship Of The Ring             38
## 179 The Fellowship Of The Ring             38
## 180 The Fellowship Of The Ring             38
## 181 The Fellowship Of The Ring             38
## 182 The Fellowship Of The Ring             38
## 183 The Fellowship Of The Ring             38
## 184 The Fellowship Of The Ring             38
## 185 The Fellowship Of The Ring             39
## 186 The Fellowship Of The Ring             39
## 187 The Fellowship Of The Ring             40
## 188 The Fellowship Of The Ring             40
## 189 The Fellowship Of The Ring             41
## 190 The Fellowship Of The Ring             41
## 191 The Fellowship Of The Ring             41
## 192 The Fellowship Of The Ring             41
## 193 The Fellowship Of The Ring             41
## 194 The Fellowship Of The Ring             41
## 195 The Fellowship Of The Ring             41
## 196 The Fellowship Of The Ring             41
## 197 The Fellowship Of The Ring             42
## 198 The Fellowship Of The Ring             42
## 199 The Fellowship Of The Ring             42
## 200 The Fellowship Of The Ring             42
## 201 The Fellowship Of The Ring             43
## 202 The Fellowship Of The Ring             43
## 203 The Fellowship Of The Ring             43
## 204 The Fellowship Of The Ring             43
## 205 The Fellowship Of The Ring             43
## 206 The Fellowship Of The Ring             43
## 207 The Fellowship Of The Ring             43
## 208 The Fellowship Of The Ring             44
## 209 The Fellowship Of The Ring             44
## 210 The Fellowship Of The Ring             44
## 211 The Fellowship Of The Ring             44
## 212 The Fellowship Of The Ring             44
## 213 The Fellowship Of The Ring             44
## 214 The Fellowship Of The Ring             44
## 215 The Fellowship Of The Ring             45
## 216 The Fellowship Of The Ring             45
## 217 The Fellowship Of The Ring             46
## 218 The Fellowship Of The Ring             46
## 219 The Fellowship Of The Ring             46
## 220 The Fellowship Of The Ring             46
## 221 The Fellowship Of The Ring             46
## 222 The Fellowship Of The Ring             46
## 223             The Two Towers             01
## 224             The Two Towers             01
## 225             The Two Towers             01
## 226             The Two Towers             01
## 227             The Two Towers             02
## 228             The Two Towers             02
## 229             The Two Towers             03
## 230             The Two Towers             03
## 231             The Two Towers             03
## 232             The Two Towers             03
## 233             The Two Towers             04
## 234             The Two Towers             04
## 235             The Two Towers             04
## 236             The Two Towers             04
## 237             The Two Towers             04
## 238             The Two Towers             05
## 239             The Two Towers             05
## 240             The Two Towers             05
## 241             The Two Towers             06
## 242             The Two Towers             06
## 243             The Two Towers             06
## 244             The Two Towers             06
## 245             The Two Towers             06
## 246             The Two Towers             06
## 247             The Two Towers             07
## 248             The Two Towers             07
## 249             The Two Towers             08
## 250             The Two Towers             08
## 251             The Two Towers             08
## 252             The Two Towers             08
## 253             The Two Towers             09
## 254             The Two Towers             09
## 255             The Two Towers             10
## 256             The Two Towers             10
## 257             The Two Towers             10
## 258             The Two Towers             10
## 259             The Two Towers             10
## 260             The Two Towers             10
## 261             The Two Towers             10
## 262             The Two Towers             11
## 263             The Two Towers             11
## 264             The Two Towers             11
## 265             The Two Towers             11
## 266             The Two Towers             12
## 267             The Two Towers             12
## 268             The Two Towers             12
## 269             The Two Towers             13
## 270             The Two Towers             13
## 271             The Two Towers             13
## 272             The Two Towers             13
## 273             The Two Towers             14
## 274             The Two Towers             14
## 275             The Two Towers             14
## 276             The Two Towers             15
## 277             The Two Towers             15
## 278             The Two Towers             15
## 279             The Two Towers             15
## 280             The Two Towers             16
## 281             The Two Towers             16
## 282             The Two Towers             17
## 283             The Two Towers             17
## 284             The Two Towers             18
## 285             The Two Towers             18
## 286             The Two Towers             18
## 287             The Two Towers             19
## 288             The Two Towers             19
## 289             The Two Towers             19
## 290             The Two Towers             20
## 291             The Two Towers             20
## 292             The Two Towers             20
## 293             The Two Towers             20
## 294             The Two Towers             20
## 295             The Two Towers             20
## 296             The Two Towers             20
## 297             The Two Towers             21
## 298             The Two Towers             22
## 299             The Two Towers             22
## 300             The Two Towers             23
## 301             The Two Towers             23
## 302             The Two Towers             23
## 303             The Two Towers             23
## 304             The Two Towers             23
## 305             The Two Towers             23
## 306             The Two Towers             23
## 307             The Two Towers             24
## 308             The Two Towers             24
## 309             The Two Towers             24
## 310             The Two Towers             25
## 311             The Two Towers             25
## 312             The Two Towers             25
## 313             The Two Towers             26
## 314             The Two Towers             26
## 315             The Two Towers             27
## 316             The Two Towers             27
## 317             The Two Towers             28
## 318             The Two Towers             28
## 319             The Two Towers             29
## 320             The Two Towers             29
## 321             The Two Towers             30
## 322             The Two Towers             30
## 323             The Two Towers             30
## 324             The Two Towers             30
## 325             The Two Towers             31
## 326             The Two Towers             31
## 327             The Two Towers             32
## 328             The Two Towers             32
## 329             The Two Towers             32
## 330             The Two Towers             32
## 331             The Two Towers             33
## 332             The Two Towers             33
## 333             The Two Towers             33
## 334             The Two Towers             33
## 335             The Two Towers             34
## 336             The Two Towers             34
## 337             The Two Towers             34
## 338             The Two Towers             34
## 339             The Two Towers             34
## 340             The Two Towers             34
## 341             The Two Towers             34
## 342             The Two Towers             34
## 343             The Two Towers             35
## 344             The Two Towers             35
## 345             The Two Towers             35
## 346             The Two Towers             35
## 347             The Two Towers             35
## 348             The Two Towers             35
## 349             The Two Towers             35
## 350             The Two Towers             35
## 351             The Two Towers             36
## 352             The Two Towers             36
## 353             The Two Towers             36
## 354             The Two Towers             36
## 355             The Two Towers             36
## 356             The Two Towers             37
## 357             The Two Towers             38
## 358             The Two Towers             38
## 359             The Two Towers             39
## 360             The Two Towers             40
## 361             The Two Towers             40
## 362             The Two Towers             40
## 363             The Two Towers             40
## 364             The Two Towers             41
## 365             The Two Towers             41
## 366             The Two Towers             41
## 367             The Two Towers             41
## 368             The Two Towers             42
## 369             The Two Towers             42
## 370             The Two Towers             42
## 371             The Two Towers             42
## 372             The Two Towers             42
## 373             The Two Towers             42
## 374             The Two Towers             43
## 375             The Two Towers             43
## 376             The Two Towers             43
## 377             The Two Towers             43
## 378             The Two Towers             43
## 379             The Two Towers             43
## 380             The Two Towers             44
## 381             The Two Towers             44
## 382             The Two Towers             45
## 383             The Two Towers             45
## 384             The Two Towers             45
## 385             The Two Towers             45
## 386             The Two Towers             45
## 387             The Two Towers             46
## 388             The Two Towers             46
## 389             The Two Towers             47
## 390             The Two Towers             47
## 391             The Two Towers             47
## 392             The Two Towers             48
## 393             The Two Towers             48
## 394             The Two Towers             48
## 395             The Two Towers             48
## 396             The Two Towers             48
## 397             The Two Towers             48
## 398             The Two Towers             48
## 399             The Two Towers             49
## 400             The Two Towers             49
## 401             The Two Towers             49
## 402             The Two Towers             49
## 403             The Two Towers             49
## 404             The Two Towers             49
## 405             The Two Towers             50
## 406             The Two Towers             50
## 407             The Two Towers             50
## 408             The Two Towers             51
## 409             The Two Towers             51
## 410             The Two Towers             51
## 411             The Two Towers             52
## 412             The Two Towers             52
## 413             The Two Towers             52
## 414             The Two Towers             53
## 415             The Two Towers             53
## 416             The Two Towers             53
## 417             The Two Towers             53
## 418             The Two Towers             53
## 419             The Two Towers             53
## 420             The Two Towers             54
## 421             The Two Towers             54
## 422             The Two Towers             54
## 423             The Two Towers             55
## 424             The Two Towers             55
## 425             The Two Towers             55
## 426             The Two Towers             56
## 427             The Two Towers             56
## 428             The Two Towers             56
## 429             The Two Towers             57
## 430             The Two Towers             57
## 431             The Two Towers             57
## 432             The Two Towers             57
## 433             The Two Towers             58
## 434             The Two Towers             58
## 435             The Two Towers             58
## 436             The Two Towers             58
## 437             The Two Towers             58
## 438             The Two Towers             58
## 439             The Two Towers             58
## 440             The Two Towers             59
## 441             The Two Towers             59
## 442             The Two Towers             59
## 443             The Two Towers             60
## 444             The Two Towers             60
## 445             The Two Towers             60
## 446             The Two Towers             60
## 447             The Two Towers             60
## 448             The Two Towers             61
## 449             The Two Towers             62
## 450             The Two Towers             62
## 451             The Two Towers             63
## 452             The Two Towers             63
## 453             The Two Towers             64
## 454             The Two Towers             64
## 455             The Two Towers             64
## 456             The Two Towers             64
## 457             The Two Towers             65
## 458             The Two Towers             65
## 459             The Two Towers             65
## 460             The Two Towers             66
## 461             The Two Towers             66
## 462             The Two Towers             66
## 463             The Two Towers             66
## 464     The Return Of The King             01
## 465     The Return Of The King             01
## 466     The Return Of The King             01
## 467     The Return Of The King             02
## 468     The Return Of The King             02
## 469     The Return Of The King             02
## 470     The Return Of The King             03
## 471     The Return Of The King             03
## 472     The Return Of The King             03
## 473     The Return Of The King             03
## 474     The Return Of The King             04
## 475     The Return Of The King             04
## 476     The Return Of The King             04
## 477     The Return Of The King             04
## 478     The Return Of The King             04
## 479     The Return Of The King             04
## 480     The Return Of The King             04
## 481     The Return Of The King             05
## 482     The Return Of The King             05
## 483     The Return Of The King             05
## 484     The Return Of The King             05
## 485     The Return Of The King             05
## 486     The Return Of The King             05
## 487     The Return Of The King             05
## 488     The Return Of The King             05
## 489     The Return Of The King             05
## 490     The Return Of The King             05
## 491     The Return Of The King             06
## 492     The Return Of The King             06
## 493     The Return Of The King             06
## 494     The Return Of The King             06
## 495     The Return Of The King             07
## 496     The Return Of The King             07
## 497     The Return Of The King             08
## 498     The Return Of The King             08
## 499     The Return Of The King             08
## 500     The Return Of The King             08
## 501     The Return Of The King             08
## 502     The Return Of The King             08
## 503     The Return Of The King             09
## 504     The Return Of The King             09
## 505     The Return Of The King             10
## 506     The Return Of The King             10
## 507     The Return Of The King             11
## 508     The Return Of The King             11
## 509     The Return Of The King             11
## 510     The Return Of The King             12
## 511     The Return Of The King             12
## 512     The Return Of The King             13
## 513     The Return Of The King             13
## 514     The Return Of The King             13
## 515     The Return Of The King             14
## 516     The Return Of The King             14
## 517     The Return Of The King             14
## 518     The Return Of The King             15
## 519     The Return Of The King             15
## 520     The Return Of The King             15
## 521     The Return Of The King             15
## 522     The Return Of The King             16
## 523     The Return Of The King             16
## 524     The Return Of The King             16
## 525     The Return Of The King             17
## 526     The Return Of The King             18
## 527     The Return Of The King             18
## 528     The Return Of The King             18
## 529     The Return Of The King             18
## 530     The Return Of The King             18
## 531     The Return Of The King             19
## 532     The Return Of The King             19
## 533     The Return Of The King             20
## 534     The Return Of The King             20
## 535     The Return Of The King             20
## 536     The Return Of The King             20
## 537     The Return Of The King             20
## 538     The Return Of The King             20
## 539     The Return Of The King             20
## 540     The Return Of The King             20
## 541     The Return Of The King             20
## 542     The Return Of The King             21
## 543     The Return Of The King             21
## 544     The Return Of The King             21
## 545     The Return Of The King             21
## 546     The Return Of The King             21
## 547     The Return Of The King             21
## 548     The Return Of The King             21
## 549     The Return Of The King             21
## 550     The Return Of The King             22
## 551     The Return Of The King             22
## 552     The Return Of The King             23
## 553     The Return Of The King             23
## 554     The Return Of The King             24
## 555     The Return Of The King             24
## 556     The Return Of The King             24
## 557     The Return Of The King             24
## 558     The Return Of The King             25
## 559     The Return Of The King             25
## 560     The Return Of The King             26
## 561     The Return Of The King             26
## 562     The Return Of The King             26
## 563     The Return Of The King             27
## 564     The Return Of The King             27
## 565     The Return Of The King             27
## 566     The Return Of The King             28
## 567     The Return Of The King             28
## 568     The Return Of The King             28
## 569     The Return Of The King             28
## 570     The Return Of The King             28
## 571     The Return Of The King             29
## 572     The Return Of The King             29
## 573     The Return Of The King             29
## 574     The Return Of The King             29
## 575     The Return Of The King             29
## 576     The Return Of The King             29
## 577     The Return Of The King             29
## 578     The Return Of The King             29
## 579     The Return Of The King             29
## 580     The Return Of The King             30
## 581     The Return Of The King             30
## 582     The Return Of The King             30
## 583     The Return Of The King             30
## 584     The Return Of The King             30
## 585     The Return Of The King             31
## 586     The Return Of The King             31
## 587     The Return Of The King             31
## 588     The Return Of The King             31
## 589     The Return Of The King             31
## 590     The Return Of The King             31
## 591     The Return Of The King             31
## 592     The Return Of The King             32
## 593     The Return Of The King             32
## 594     The Return Of The King             33
## 595     The Return Of The King             33
## 596     The Return Of The King             33
## 597     The Return Of The King             34
## 598     The Return Of The King             34
## 599     The Return Of The King             34
## 600     The Return Of The King             34
## 601     The Return Of The King             35
## 602     The Return Of The King             35
## 603     The Return Of The King             35
## 604     The Return Of The King             35
## 605     The Return Of The King             36
## 606     The Return Of The King             36
## 607     The Return Of The King             36
## 608     The Return Of The King             36
## 609     The Return Of The King             36
## 610     The Return Of The King             36
## 611     The Return Of The King             36
## 612     The Return Of The King             37
## 613     The Return Of The King             37
## 614     The Return Of The King             37
## 615     The Return Of The King             37
## 616     The Return Of The King             38
## 617     The Return Of The King             38
## 618     The Return Of The King             38
## 619     The Return Of The King             38
## 620     The Return Of The King             38
## 621     The Return Of The King             39
## 622     The Return Of The King             39
## 623     The Return Of The King             39
## 624     The Return Of The King             39
## 625     The Return Of The King             40
## 626     The Return Of The King             41
## 627     The Return Of The King             42
## 628     The Return Of The King             43
## 629     The Return Of The King             43
## 630     The Return Of The King             43
## 631     The Return Of The King             44
## 632     The Return Of The King             44
## 633     The Return Of The King             44
## 634     The Return Of The King             45
## 635     The Return Of The King             45
## 636     The Return Of The King             45
## 637     The Return Of The King             45
## 638     The Return Of The King             45
## 639     The Return Of The King             46
## 640     The Return Of The King             46
## 641     The Return Of The King             46
## 642     The Return Of The King             46
## 643     The Return Of The King             46
## 644     The Return Of The King             47
## 645     The Return Of The King             47
## 646     The Return Of The King             47
## 647     The Return Of The King             48
## 648     The Return Of The King             48
## 649     The Return Of The King             48
## 650     The Return Of The King             48
## 651     The Return Of The King             49
## 652     The Return Of The King             49
## 653     The Return Of The King             50
## 654     The Return Of The King             50
## 655     The Return Of The King             50
## 656     The Return Of The King             51
## 657     The Return Of The King             51
## 658     The Return Of The King             52
## 659     The Return Of The King             52
## 660     The Return Of The King             53
## 661     The Return Of The King             53
## 662     The Return Of The King             53
## 663     The Return Of The King             53
## 664     The Return Of The King             53
## 665     The Return Of The King             54
## 666     The Return Of The King             54
## 667     The Return Of The King             55
## 668     The Return Of The King             55
## 669     The Return Of The King             55
## 670     The Return Of The King             56
## 671     The Return Of The King             56
## 672     The Return Of The King             57
## 673     The Return Of The King             57
## 674     The Return Of The King             58
## 675     The Return Of The King             58
## 676     The Return Of The King             58
## 677     The Return Of The King             58
## 678     The Return Of The King             59
## 679     The Return Of The King             59
## 680     The Return Of The King             59
## 681     The Return Of The King             59
## 682     The Return Of The King             59
## 683     The Return Of The King             60
## 684     The Return Of The King             61
## 685     The Return Of The King             61
## 686     The Return Of The King             62
## 687     The Return Of The King             62
## 688     The Return Of The King             62
## 689     The Return Of The King             63
## 690     The Return Of The King             63
## 691     The Return Of The King             64
## 692     The Return Of The King             64
## 693     The Return Of The King             64
## 694     The Return Of The King             64
## 695     The Return Of The King             64
## 696     The Return Of The King             64
## 697     The Return Of The King             65
## 698     The Return Of The King             65
## 699     The Return Of The King             65
## 700     The Return Of The King             65
## 701     The Return Of The King             66
## 702     The Return Of The King             66
## 703     The Return Of The King             67
## 704     The Return Of The King             67
## 705     The Return Of The King             68
## 706     The Return Of The King             68
## 707     The Return Of The King             68
## 708     The Return Of The King             69
## 709     The Return Of The King             70
## 710     The Return Of The King             70
## 711     The Return Of The King             70
## 712     The Return Of The King             71
## 713     The Return Of The King             71
## 714     The Return Of The King             72
## 715     The Return Of The King             72
## 716     The Return Of The King             73
## 717     The Return Of The King             73
## 718     The Return Of The King             73
## 719     The Return Of The King             74
## 720     The Return Of The King             74
## 721     The Return Of The King             75
## 722     The Return Of The King             75
## 723     The Return Of The King             75
## 724     The Return Of The King             75
## 725     The Return Of The King             75
## 726     The Return Of The King             76
## 727     The Return Of The King             76
## 728     The Return Of The King             76
## 729     The Return Of The King             76
## 730     The Return Of The King             76
## 731     The Return Of The King             76
##                                       Chapter_Name
## 1                                         Prologue
## 2                                         Prologue
## 3                                         Prologue
## 4                                         Prologue
## 5                               Concerning Hobbits
## 6                                        The Shire
## 7                                        The Shire
## 8                                        The Shire
## 9                                        The Shire
## 10                                       The Shire
## 11                                Very Old Friends
## 12                                Very Old Friends
## 13                                Very Old Friends
## 14                           A Long Expected Party
## 15                           A Long Expected Party
## 16                           A Long Expected Party
## 17                           A Long Expected Party
## 18                           A Long Expected Party
## 19                           A Long Expected Party
## 20                           A Long Expected Party
## 21                           A Long Expected Party
## 22                           A Long Expected Party
## 23                           A Long Expected Party
## 24                             Farewell Dear Bilbo
## 25                             Farewell Dear Bilbo
## 26                    Keep It Secret, Keep It Safe
## 27                    Keep It Secret, Keep It Safe
## 28                    Keep It Secret, Keep It Safe
## 29                          The Account of Isildur
## 30                          The Account of Isildur
## 31                          The Account of Isildur
## 32                          The Account of Isildur
## 33                             At The Green Dragon
## 34                             At The Green Dragon
## 35                             At The Green Dragon
## 36                             At The Green Dragon
## 37                             At The Green Dragon
## 38                             At The Green Dragon
## 39                             At The Green Dragon
## 40                             At The Green Dragon
## 41                             At The Green Dragon
## 42                          The Shadow Of The Past
## 43                          The Shadow Of The Past
## 44                          The Shadow Of The Past
## 45                          The Shadow Of The Past
## 46                          The Shadow Of The Past
## 47                          The Shadow Of The Past
## 48                        The Passing Of The Elves
## 49                        The Passing Of The Elves
## 50                               Saruman The White
## 51                               Saruman The White
## 52                         A Shortcut To Mushrooms
## 53                         A Shortcut To Mushrooms
## 54                         A Shortcut To Mushrooms
## 55                         A Shortcut To Mushrooms
## 56                         A Shortcut To Mushrooms
## 57                               Buckleberry Ferry
## 58                               Buckleberry Ferry
## 59                               Buckleberry Ferry
## 60                               Buckleberry Ferry
## 61                At The Sign of the Prancing Pony
## 62                At The Sign of the Prancing Pony
## 63                At The Sign of the Prancing Pony
## 64                At The Sign of the Prancing Pony
## 65                At The Sign of the Prancing Pony
## 66                At The Sign of the Prancing Pony
## 67                At The Sign of the Prancing Pony
## 68                At The Sign of the Prancing Pony
## 69                At The Sign of the Prancing Pony
## 70                                      The Nazgul
## 71                                      The Nazgul
## 72                                      The Nazgul
## 73                                      The Nazgul
## 74                                      The Nazgul
## 75                          The Midgewater Marshes
## 76                          The Midgewater Marshes
## 77                          The Midgewater Marshes
## 78                        The Spoiling Of Isengard
## 79                        The Spoiling Of Isengard
## 80                        The Spoiling Of Isengard
## 81                             A Knife In The Dark
## 82                             A Knife In The Dark
## 83                             A Knife In The Dark
## 84                             A Knife In The Dark
## 85                             A Knife In The Dark
## 86                         The Caverns Of Isengard
## 87                              Flight To The Ford
## 88                              Flight To The Ford
## 89                              Flight To The Ford
## 90                              Flight To The Ford
## 91                              Flight To The Ford
## 92                              Flight To The Ford
## 93                                       Rivendell
## 94                                   Many Meetings
## 95                                   Many Meetings
## 96                                   Many Meetings
## 97                                   Many Meetings
## 98                                   Many Meetings
## 99                                   Many Meetings
## 100                           The Fate Of The Ring
## 101                           The Fate Of The Ring
## 102                           The Fate Of The Ring
## 103                      The Sword That Was Broken
## 104                      The Sword That Was Broken
## 105                      The Sword That Was Broken
## 106                                   The Evenstar
## 107                                   The Evenstar
## 108                          The Council Of Elrond
## 109                          The Council Of Elrond
## 110                          The Council Of Elrond
## 111                          The Council Of Elrond
## 112                          The Council Of Elrond
## 113                          The Council Of Elrond
## 114                          The Council Of Elrond
## 115                          The Council Of Elrond
## 116                          The Council Of Elrond
## 117                          The Council Of Elrond
## 118                          The Council Of Elrond
## 119                          The Council Of Elrond
## 120                             Gilraen's Memorial
## 121                             Gilraen's Memorial
## 122                                  Bilbo's Gifts
## 123                                  Bilbo's Gifts
## 124                The Departure Of The Fellowship
## 125                The Departure Of The Fellowship
## 126                The Departure Of The Fellowship
## 127                            The Ring Goes South
## 128                            The Ring Goes South
## 129                            The Ring Goes South
## 130                            The Ring Goes South
## 131                            The Ring Goes South
## 132                            The Ring Goes South
## 133                            The Ring Goes South
## 134                            The Ring Goes South
## 135                          The Pass Of Caradhras
## 136                          The Pass Of Caradhras
## 137                          The Pass Of Caradhras
## 138                          The Pass Of Caradhras
## 139                          The Pass Of Caradhras
## 140                          The Pass Of Caradhras
## 141                          The Pass Of Caradhras
## 142                                          Moria
## 143                                          Moria
## 144                                          Moria
## 145                                          Moria
## 146                                          Moria
## 147                                          Moria
## 148                                          Moria
## 149                                          Moria
## 150                                          Moria
## 151                          A Journey In The Dark
## 152                          A Journey In The Dark
## 153                          A Journey In The Dark
## 154                          A Journey In The Dark
## 155                          A Journey In The Dark
## 156                          A Journey In The Dark
## 157                                   Balin's Tomb
## 158                                   Balin's Tomb
## 159                                   Balin's Tomb
## 160                                   Balin's Tomb
## 161                                   Balin's Tomb
## 162                                   Balin's Tomb
## 163                                   Balin's Tomb
## 164                       The Bridge Of Khazad-dûm
## 165                       The Bridge Of Khazad-dûm
## 166                       The Bridge Of Khazad-dûm
## 167                       The Bridge Of Khazad-dûm
## 168                       The Bridge Of Khazad-dûm
## 169                       The Bridge Of Khazad-dûm
## 170                                     Lothlorien
## 171                                     Lothlorien
## 172                                     Lothlorien
## 173                                     Lothlorien
## 174                                     Lothlorien
## 175                                     Lothlorien
## 176                                     Lothlorien
## 177                                 Caras Galadhon
## 178                                 Caras Galadhon
## 179                                 Caras Galadhon
## 180                                 Caras Galadhon
## 181                                 Caras Galadhon
## 182                                 Caras Galadhon
## 183                                 Caras Galadhon
## 184                                 Caras Galadhon
## 185                        The Mirror Of Galadriel
## 186                        The Mirror Of Galadriel
## 187                          The Fighting Uruk-hai
## 188                          The Fighting Uruk-hai
## 189                             Farewell To Lorien
## 190                             Farewell To Lorien
## 191                             Farewell To Lorien
## 192                             Farewell To Lorien
## 193                             Farewell To Lorien
## 194                             Farewell To Lorien
## 195                             Farewell To Lorien
## 196                             Farewell To Lorien
## 197                                The Great River
## 198                                The Great River
## 199                                The Great River
## 200                                The Great River
## 201                                    Parth Galen
## 202                                    Parth Galen
## 203                                    Parth Galen
## 204                                    Parth Galen
## 205                                    Parth Galen
## 206                                    Parth Galen
## 207                                    Parth Galen
## 208                 The Breaking Of The Fellowship
## 209                 The Breaking Of The Fellowship
## 210                 The Breaking Of The Fellowship
## 211                 The Breaking Of The Fellowship
## 212                 The Breaking Of The Fellowship
## 213                 The Breaking Of The Fellowship
## 214                 The Breaking Of The Fellowship
## 215                       The Departure Of Boromir
## 216                       The Departure Of Boromir
## 217                         The Road Goes Ever On…
## 218                         The Road Goes Ever On…
## 219                         The Road Goes Ever On…
## 220                         The Road Goes Ever On…
## 221                         The Road Goes Ever On…
## 222                         The Road Goes Ever On…
## 223                       The Foundations Of Stone
## 224                       The Foundations Of Stone
## 225                       The Foundations Of Stone
## 226                       The Foundations Of Stone
## 227                                     Elven Rope
## 228                                     Elven Rope
## 229                          The Taming of Sméagol
## 230                          The Taming of Sméagol
## 231                          The Taming of Sméagol
## 232                          The Taming of Sméagol
## 233                                   The Uruk-Hai
## 234                                   The Uruk-Hai
## 235                                   The Uruk-Hai
## 236                                   The Uruk-Hai
## 237                                   The Uruk-Hai
## 238                              The Three Hunters
## 239                              The Three Hunters
## 240                              The Three Hunters
## 241                    The Burning of the Westfold
## 242                    The Burning of the Westfold
## 243                    The Burning of the Westfold
## 244                    The Burning of the Westfold
## 245                    The Burning of the Westfold
## 246                    The Burning of the Westfold
## 247                  Massacre at the Fords of Isen
## 248                  Massacre at the Fords of Isen
## 249                        The Banishment of Éomer
## 250                        The Banishment of Éomer
## 251                        The Banishment of Éomer
## 252                        The Banishment of Éomer
## 253                   On The Trail Of The Uruk-Hai
## 254                   On The Trail Of The Uruk-Hai
## 255                          Night Camp At Fangorn
## 256                          Night Camp At Fangorn
## 257                          Night Camp At Fangorn
## 258                          Night Camp At Fangorn
## 259                          Night Camp At Fangorn
## 260                          Night Camp At Fangorn
## 261                          Night Camp At Fangorn
## 262                            The Riders Of Rohan
## 263                            The Riders Of Rohan
## 264                            The Riders Of Rohan
## 265                            The Riders Of Rohan
## 266                   The Fate Of Merry And Pippin
## 267                   The Fate Of Merry And Pippin
## 268                   The Fate Of Merry And Pippin
## 269                                      Treebeard
## 270                                      Treebeard
## 271                                      Treebeard
## 272                                      Treebeard
## 273                     The Passage Of The Marshes
## 274                     The Passage Of The Marshes
## 275                     The Passage Of The Marshes
## 276                                The White Rider
## 277                                The White Rider
## 278                                The White Rider
## 279                                The White Rider
## 280                       The Song Of The Entwives
## 281                       The Song Of The Entwives
## 282                            The Heir Of Númenor
## 283                            The Heir Of Númenor
## 284                       The Black Gate Is Closed
## 285                       The Black Gate Is Closed
## 286                       The Black Gate Is Closed
## 287                                      Ent Draft
## 288                                      Ent Draft
## 289                                      Ent Draft
## 290                    The King Of The Golden Hall
## 291                    The King Of The Golden Hall
## 292                    The King Of The Golden Hall
## 293                    The King Of The Golden Hall
## 294                    The King Of The Golden Hall
## 295                    The King Of The Golden Hall
## 296                    The King Of The Golden Hall
## 297                        The Funeral Of Théodred
## 298                Simbelmynë on the Burial Mounds
## 299                Simbelmynë on the Burial Mounds
## 300                            The King's Decision
## 301                            The King's Decision
## 302                            The King's Decision
## 303                            The King's Decision
## 304                            The King's Decision
## 305                            The King's Decision
## 306                            The King's Decision
## 307                                          Brego
## 308                                          Brego
## 309                                          Brego
## 310                            The Ring Of Barahir
## 311                            The Ring Of Barahir
## 312                            The Ring Of Barahir
## 313                            A Daughter Of Kings
## 314                            A Daughter Of Kings
## 315                             Exodus From Edoras
## 316                             Exodus From Edoras
## 317                        The Forests Of Ithilien
## 318                        The Forests Of Ithilien
## 319                            Gollum and Sméagol 
## 320                            Gollum and Sméagol 
## 321                     Of Herbs And Stewed Rabbit
## 322                     Of Herbs And Stewed Rabbit
## 323                     Of Herbs And Stewed Rabbit
## 324                     Of Herbs And Stewed Rabbit
## 325                                    Dwarf Women
## 326                                    Dwarf Women
## 327                            One of the Dúnedain
## 328                            One of the Dúnedain
## 329                            One of the Dúnedain
## 330                            One of the Dúnedain
## 331                                   The Evenstar
## 332                                   The Evenstar
## 333                                   The Evenstar
## 334                                   The Evenstar
## 335                         The Wolves Of Isengard
## 336                         The Wolves Of Isengard
## 337                         The Wolves Of Isengard
## 338                         The Wolves Of Isengard
## 339                         The Wolves Of Isengard
## 340                         The Wolves Of Isengard
## 341                         The Wolves Of Isengard
## 342                         The Wolves Of Isengard
## 343                                    Helm's Deep
## 344                                    Helm's Deep
## 345                                    Helm's Deep
## 346                                    Helm's Deep
## 347                                    Helm's Deep
## 348                                    Helm's Deep
## 349                                    Helm's Deep
## 350                                    Helm's Deep
## 351                             Isengard Unleashed
## 352                             Isengard Unleashed
## 353                             Isengard Unleashed
## 354                             Isengard Unleashed
## 355                             Isengard Unleashed
## 356                         The Grace Of The Valar
## 357                                   Arwen's Fate
## 358                                   Arwen's Fate
## 359                 The Story Foreseen From Lórien
## 360                        The Windows On The West
## 361                        The Windows On The West
## 362                        The Windows On The West
## 363                        The Windows On The West
## 364                            Sons Of The Steward
## 365                            Sons Of The Steward
## 366                            Sons Of The Steward
## 367                            Sons Of The Steward
## 368                             The Forbidden Pool
## 369                             The Forbidden Pool
## 370                             The Forbidden Pool
## 371                             The Forbidden Pool
## 372                             The Forbidden Pool
## 373                             The Forbidden Pool
## 374                               Aragorn's Return
## 375                               Aragorn's Return
## 376                               Aragorn's Return
## 377                               Aragorn's Return
## 378                               Aragorn's Return
## 379                               Aragorn's Return
## 380                                        Entmoot
## 381                                        Entmoot
## 382                           The Glittering Caves
## 383                           The Glittering Caves
## 384                           The Glittering Caves
## 385                           The Glittering Caves
## 386                           The Glittering Caves
## 387               Where Is The Horse And The Rider
## 388               Where Is The Horse And The Rider
## 389               Don't Be Hasty, Master Meriadoc!
## 390               Don't Be Hasty, Master Meriadoc!
## 391               Don't Be Hasty, Master Meriadoc!
## 392                          The Host Of The Eldar
## 393                          The Host Of The Eldar
## 394                          The Host Of The Eldar
## 395                          The Host Of The Eldar
## 396                          The Host Of The Eldar
## 397                          The Host Of The Eldar
## 398                          The Host Of The Eldar
## 399                     The Battle Of The Hornburg
## 400                     The Battle Of The Hornburg
## 401                     The Battle Of The Hornburg
## 402                     The Battle Of The Hornburg
## 403                     The Battle Of The Hornburg
## 404                     The Battle Of The Hornburg
## 405                                     Old Entish
## 406                                     Old Entish
## 407                                     Old Entish
## 408                 The Breach Of The Deeping Wall
## 409                 The Breach Of The Deeping Wall
## 410                 The Breach Of The Deeping Wall
## 411                            The Entmoot Decides
## 412                            The Entmoot Decides
## 413                            The Entmoot Decides
## 414                    The Retreat To The Hornburg
## 415                    The Retreat To The Hornburg
## 416                    The Retreat To The Hornburg
## 417                    The Retreat To The Hornburg
## 418                    The Retreat To The Hornburg
## 419                    The Retreat To The Hornburg
## 420                         Master Peregrin's Plan
## 421                         Master Peregrin's Plan
## 422                         Master Peregrin's Plan
## 423                                      Osgiliath
## 424                                      Osgiliath
## 425                                      Osgiliath
## 426                     The Last March Of The Ents
## 427                     The Last March Of The Ents
## 428                     The Last March Of The Ents
## 429                              The Nazgûl Attack
## 430                              The Nazgûl Attack
## 431                              The Nazgûl Attack
## 432                              The Nazgûl Attack
## 433                                Forth Eorlingas
## 434                                Forth Eorlingas
## 435                                Forth Eorlingas
## 436                                Forth Eorlingas
## 437                                Forth Eorlingas
## 438                                Forth Eorlingas
## 439                                Forth Eorlingas
## 440                       The Flooding Of Isengard
## 441                       The Flooding Of Isengard
## 442                       The Flooding Of Isengard
## 443                The Tales That Really Mattered…
## 444                The Tales That Really Mattered…
## 445                The Tales That Really Mattered…
## 446                The Tales That Really Mattered…
## 447                The Tales That Really Mattered…
## 448                   Fangorn Comes To Helm's Deep
## 449                                The Final Tally
## 450                                The Final Tally
## 451                             Flotsam And Jetsam
## 452                             Flotsam And Jetsam
## 453                            Farewell To Faramir
## 454                            Farewell To Faramir
## 455                            Farewell To Faramir
## 456                            Farewell To Faramir
## 457  The Battle For Middle Earth Is About To Begin
## 458  The Battle For Middle Earth Is About To Begin
## 459  The Battle For Middle Earth Is About To Begin
## 460                                  Gollum's Plan
## 461                                  Gollum's Plan
## 462                                  Gollum's Plan
## 463                                  Gollum's Plan
## 464                        The Finding Of The Ring
## 465                        The Finding Of The Ring
## 466                        The Finding Of The Ring
## 467                     Journey To The Cross-roads
## 468                     Journey To The Cross-roads
## 469                     Journey To The Cross-roads
## 470                           The Road To Isengard
## 471                           The Road To Isengard
## 472                           The Road To Isengard
## 473                           The Road To Isengard
## 474                           The Voice Of Saruman
## 475                           The Voice Of Saruman
## 476                           The Voice Of Saruman
## 477                           The Voice Of Saruman
## 478                           The Voice Of Saruman
## 479                           The Voice Of Saruman
## 480                           The Voice Of Saruman
## 481                               Return To Edoras
## 482                               Return To Edoras
## 483                               Return To Edoras
## 484                               Return To Edoras
## 485                               Return To Edoras
## 486                               Return To Edoras
## 487                               Return To Edoras
## 488                               Return To Edoras
## 489                               Return To Edoras
## 490                               Return To Edoras
## 491                               Gollum's Villany
## 492                               Gollum's Villany
## 493                               Gollum's Villany
## 494                               Gollum's Villany
## 495                                  Eowyn's Dream
## 496                                  Eowyn's Dream
## 497                                   The Palantir
## 498                                   The Palantir
## 499                                   The Palantir
## 500                                   The Palantir
## 501                                   The Palantir
## 502                                   The Palantir
## 503                                 Arwen's Vision
## 504                                 Arwen's Vision
## 505                        The Reforging Of Narsil
## 506                        The Reforging Of Narsil
## 507                                   Minas Tirith
## 508                                   Minas Tirith
## 509                                   Minas Tirith
## 510                          The Decline Of Gondor
## 511                          The Decline Of Gondor
## 512                 Cross-roads Of The Fallen King
## 513                 Cross-roads Of The Fallen King
## 514                 Cross-roads Of The Fallen King
## 515              The Deep Breath Before The Plunge
## 516              The Deep Breath Before The Plunge
## 517              The Deep Breath Before The Plunge
## 518                                   Minas Morgul
## 519                                   Minas Morgul
## 520                                   Minas Morgul
## 521                                   Minas Morgul
## 522                                  Sam's Warning
## 523                                  Sam's Warning
## 524                                  Sam's Warning
## 525                                  Pippin's Task
## 526                              Osgiliath Invaded
## 527                              Osgiliath Invaded
## 528                              Osgiliath Invaded
## 529                              Osgiliath Invaded
## 530                              Osgiliath Invaded
## 531                    The Lighting Of The Beacons
## 532                    The Lighting Of The Beacons
## 533                             Theoren's Decision
## 534                             Theoren's Decision
## 535                             Theoren's Decision
## 536                             Theoren's Decision
## 537                             Theoren's Decision
## 538                             Theoren's Decision
## 539                             Theoren's Decision
## 540                             Theoren's Decision
## 541                             Theoren's Decision
## 542                          The Fall of Osgiliath
## 543                          The Fall of Osgiliath
## 544                          The Fall of Osgiliath
## 545                          The Fall of Osgiliath
## 546                          The Fall of Osgiliath
## 547                          The Fall of Osgiliath
## 548                          The Fall of Osgiliath
## 549                          The Fall of Osgiliath
## 550                             The Wizard's Pupil
## 551                             The Wizard's Pupil
## 552                     The Stairs Of Cirith Ungol
## 553                     The Stairs Of Cirith Ungol
## 554                    Courage Is The Best Defense
## 555                    Courage Is The Best Defense
## 556                    Courage Is The Best Defense
## 557                    Courage Is The Best Defense
## 558                    Peregrin Of The Tower Guard
## 559                    Peregrin Of The Tower Guard
## 560                         Allegiance To Denethor
## 561                         Allegiance To Denethor
## 562                         Allegiance To Denethor
## 563                     The Parting Of Sam & Frodo
## 564                     The Parting Of Sam & Frodo
## 565                     The Parting Of Sam & Frodo
## 566                       The Sacrifice Of Faramir
## 567                       The Sacrifice Of Faramir
## 568                       The Sacrifice Of Faramir
## 569                       The Sacrifice Of Faramir
## 570                       The Sacrifice Of Faramir
## 571                       Marshalling At Dunharrow
## 572                       Marshalling At Dunharrow
## 573                       Marshalling At Dunharrow
## 574                       Marshalling At Dunharrow
## 575                       Marshalling At Dunharrow
## 576                       Marshalling At Dunharrow
## 577                       Marshalling At Dunharrow
## 578                       Marshalling At Dunharrow
## 579                       Marshalling At Dunharrow
## 580                    Anduril - Flame Of The West
## 581                    Anduril - Flame Of The West
## 582                    Anduril - Flame Of The West
## 583                    Anduril - Flame Of The West
## 584                    Anduril - Flame Of The West
## 585            Aragorn Takes The Paths Of The Dead
## 586            Aragorn Takes The Paths Of The Dead
## 587            Aragorn Takes The Paths Of The Dead
## 588            Aragorn Takes The Paths Of The Dead
## 589            Aragorn Takes The Paths Of The Dead
## 590            Aragorn Takes The Paths Of The Dead
## 591            Aragorn Takes The Paths Of The Dead
## 592                                No More Despair
## 593                                No More Despair
## 594               Dwimoberg ~ The Haunted Mountain
## 595               Dwimoberg ~ The Haunted Mountain
## 596               Dwimoberg ~ The Haunted Mountain
## 597                            The Muster Of Rohan
## 598                            The Muster Of Rohan
## 599                            The Muster Of Rohan
## 600                            The Muster Of Rohan
## 601                          The Paths Of The Dead
## 602                          The Paths Of The Dead
## 603                          The Paths Of The Dead
## 604                          The Paths Of The Dead
## 605                            The Siege Of Gondor
## 606                            The Siege Of Gondor
## 607                            The Siege Of Gondor
## 608                            The Siege Of Gondor
## 609                            The Siege Of Gondor
## 610                            The Siege Of Gondor
## 611                            The Siege Of Gondor
## 612                          The Corsairs Of Umbar
## 613                          The Corsairs Of Umbar
## 614                          The Corsairs Of Umbar
## 615                          The Corsairs Of Umbar
## 616                                  Shelob's Lair
## 617                                  Shelob's Lair
## 618                                  Shelob's Lair
## 619                                  Shelob's Lair
## 620                                  Shelob's Lair
## 621                         Merry's Simple Courage
## 622                         Merry's Simple Courage
## 623                         Merry's Simple Courage
## 624                         Merry's Simple Courage
## 625           Grond ~ The Hammer Of The Underworld
## 626                       The Tomb Of The Stewards
## 627                    Breaking The Gate Of Gondor
## 628           The Choices Of Master Samwise Gamgee
## 629           The Choices Of Master Samwise Gamgee
## 630           The Choices Of Master Samwise Gamgee
## 631                             Denethor's Madness
## 632                             Denethor's Madness
## 633                             Denethor's Madness
## 634                          The Witch King's Hour
## 635                          The Witch King's Hour
## 636                          The Witch King's Hour
## 637                          The Witch King's Hour
## 638                          The Witch King's Hour
## 639                       The Ride Of The Rohirrim
## 640                       The Ride Of The Rohirrim
## 641                       The Ride Of The Rohirrim
## 642                       The Ride Of The Rohirrim
## 643                       The Ride Of The Rohirrim
## 644                           The Pyre Of Denethor
## 645                           The Pyre Of Denethor
## 646                           The Pyre Of Denethor
## 647              The Battle Of The Pelennor Fields
## 648              The Battle Of The Pelennor Fields
## 649              The Battle Of The Pelennor Fields
## 650              The Battle Of The Pelennor Fields
## 651                            A Far Green Country
## 652                            A Far Green Country
## 653                        The Nazgul And His Prey
## 654                        The Nazgul And His Prey
## 655                        The Nazgul And His Prey
## 656                                The Black Ships
## 657                                The Black Ships
## 658                          Shieldmaiden Of Rohan
## 659                          Shieldmaiden Of Rohan
## 660                        Victory At Minar Tirith
## 661                        Victory At Minar Tirith
## 662                        Victory At Minar Tirith
## 663                        Victory At Minar Tirith
## 664                        Victory At Minar Tirith
## 665                         The Passing Of Theoden
## 666                         The Passing Of Theoden
## 667                                Oaths Fulfilled
## 668                                Oaths Fulfilled
## 669                                Oaths Fulfilled
## 670                          The Houses Of Healing
## 671                          The Houses Of Healing
## 672                       Pippin Looks After Merry
## 673                       Pippin Looks After Merry
## 674                      The Tower Of Cirith Ungol
## 675                      The Tower Of Cirith Ungol
## 676                      The Tower Of Cirith Ungol
## 677                      The Tower Of Cirith Ungol
## 678                                The Last Debate
## 679                                The Last Debate
## 680                                The Last Debate
## 681                                The Last Debate
## 682                                The Last Debate
## 683                   Aragorn Masters The Palantir
## 684                 The Captain And The White Lady
## 685                 The Captain And The White Lady
## 686                         In The Company Of Orcs
## 687                         In The Company Of Orcs
## 688                         In The Company Of Orcs
## 689                             The Land Of Shadow
## 690                             The Land Of Shadow
## 691                            The Mouth Of Sauron
## 692                            The Mouth Of Sauron
## 693                            The Mouth Of Sauron
## 694                            The Mouth Of Sauron
## 695                            The Mouth Of Sauron
## 696                            The Mouth Of Sauron
## 697                           The Black Gate Opens
## 698                           The Black Gate Opens
## 699                           The Black Gate Opens
## 700                           The Black Gate Opens
## 701  I Can't Carry It For You… But I Can Carry You
## 702  I Can't Carry It For You… But I Can Carry You
## 703                                  The Last Move
## 704                                  The Last Move
## 705                                     Mount Doom
## 706                                     Mount Doom
## 707                                     Mount Doom
## 708                          The Eagles Are Coming
## 709                              The Crack Of Doom
## 710                              The Crack Of Doom
## 711                              The Crack Of Doom
## 712                                Sauron Defeated
## 713                                Sauron Defeated
## 714                          The End Of All Things
## 715                          The End Of All Things
## 716                        The Fellowship Reunited
## 717                        The Fellowship Reunited
## 718                        The Fellowship Reunited
## 719                         The Return Of The King
## 720                         The Return Of The King
## 721                                 Homeward Bound
## 722                                 Homeward Bound
## 723                                 Homeward Bound
## 724                                 Homeward Bound
## 725                                 Homeward Bound
## 726                                The Grey Havens
## 727                                The Grey Havens
## 728                                The Grey Havens
## 729                                The Grey Havens
## 730                                The Grey Havens
## 731                                The Grey Havens
##                     Character   Race Words
## 1                       Bilbo Hobbit     4
## 2                      Elrond    Elf     5
## 3                   Galadriel    Elf   460
## 4                      Gollum Gollum    20
## 5                       Bilbo Hobbit   214
## 6                       Bilbo Hobbit    70
## 7                       Frodo Hobbit   128
## 8                     Gandalf  Ainur   197
## 9                 Hobbit Kids Hobbit    10
## 10                    Hobbits Hobbit    12
## 11                      Bilbo Hobbit   339
## 12                    Gandalf  Ainur    64
## 13  Lobelia Sackville-Baggins Hobbit     8
## 14                      Bilbo Hobbit   326
## 15                      Frodo Hobbit    32
## 16                    Gandalf  Ainur    12
## 17                    Hobbits Hobbit     8
## 18  Lobelia Sackville-Baggins Hobbit     1
## 19                      Merry Hobbit    19
## 20           Mrs. Bracegirdle Hobbit     2
## 21                     Pippin Hobbit    15
## 22                  Proudfoot Hobbit     1
## 23                        Sam Hobbit     7
## 24                      Bilbo Hobbit   182
## 25                    Gandalf  Ainur   148
## 26                      Bilbo Hobbit     6
## 27                      Frodo Hobbit    33
## 28                    Gandalf  Ainur    60
## 29                    Gandalf  Ainur   107
## 30                     Gollum Gollum     3
## 31                    Hobbits Hobbit    12
## 32                     Nazgul Nazgul     2
## 33                      Frodo Hobbit    17
## 34                     Gaffer Hobbit    21
## 35                    Hobbits Hobbit    53
## 36                      Merry Hobbit    53
## 37                     Pippin Hobbit    61
## 38                      Rosie Hobbit     3
## 39                        Sam Hobbit    10
## 40                   Sandyman Hobbit    17
## 41                        Ted Hobbit    55
## 42                      Bilbo Hobbit    28
## 43                      Frodo Hobbit   139
## 44                    Gandalf  Ainur   541
## 45                     Gollum Gollum     2
## 46                    Hobbits Hobbit     3
## 47                        Sam Hobbit    84
## 48                      Frodo Hobbit    43
## 49                        Sam Hobbit    40
## 50                    Gandalf  Ainur    85
## 51                    Saruman  Ainur   274
## 52              Farmer Maggot Hobbit    21
## 53                      Frodo Hobbit    37
## 54                      Merry Hobbit    58
## 55                     Pippin Hobbit    32
## 56                        Sam Hobbit    48
## 57                      Frodo Hobbit    20
## 58                      Merry Hobbit    43
## 59                     Pippin Hobbit    14
## 60                        Sam Hobbit     9
## 61                    Aragorn    Men    76
## 62                      Frodo Hobbit    68
## 63                 Gatekeeper    Men    38
## 64                  Innkeeper    Men    76
## 65                        Man    Men    13
## 66                      Merry Hobbit     6
## 67                     Pippin Hobbit    39
## 68                        Sam Hobbit    30
## 69          Voice Of The Ring  Ainur    19
## 70                    Aragorn    Men    96
## 71                      Frodo Hobbit    29
## 72                      Merry Hobbit    28
## 73                     Pippin Hobbit    25
## 74                        Sam Hobbit    17
## 75                    Aragorn    Men    33
## 76                      Frodo Hobbit    12
## 77                      Merry Hobbit     9
## 78                        Orc    Orc    20
## 79                    Saruman  Ainur    22
## 80            Voice Of Sauron  Ainur     7
## 81                    Aragorn    Men    53
## 82                      Frodo Hobbit    16
## 83                      Merry Hobbit    13
## 84                     Pippin Hobbit    12
## 85                        Sam Hobbit    24
## 86                    Gandalf  Ainur     5
## 87                    Aragorn    Men    48
## 88                      Arwen    Elf   131
## 89                      Merry Hobbit     5
## 90                     Nazgul Nazgul     6
## 91                     Pippin Hobbit     9
## 92                        Sam Hobbit    34
## 93                     Elrond    Elf     7
## 94                      Bilbo Hobbit    36
## 95                     Elrond    Elf     5
## 96                      Frodo Hobbit   107
## 97                    Gandalf  Ainur   104
## 98                        Sam Hobbit    63
## 99                    Saruman  Ainur    33
## 100                    Elrond    Elf   260
## 101                   Gandalf  Ainur   102
## 102                   Isildur    Men     1
## 103                   Aragorn    Men    25
## 104                     Arwen    Elf    47
## 105                   Boromir    Men    39
## 106                   Aragorn    Men    24
## 107                     Arwen    Elf    57
## 108                   Aragorn    Men    40
## 109                   Boromir    Men   220
## 110                    Elrond    Elf   167
## 111                     Frodo Hobbit    24
## 112                   Gandalf  Ainur    85
## 113                     Gimli  Dwarf    38
## 114                   Legolas    Elf    34
## 115                       Man    Men     4
## 116                     Merry Hobbit    24
## 117                    Pippin Hobbit    18
## 118                       Sam Hobbit     8
## 119         Voice Of The Ring  Ainur    12
## 120                   Aragorn    Men    11
## 121                    Elrond    Elf    65
## 122                     Bilbo Hobbit   105
## 123                     Frodo Hobbit     3
## 124                    Elrond    Elf    48
## 125                     Frodo Hobbit     7
## 126                   Gandalf  Ainur     7
## 127                   Aragorn    Men    12
## 128                   Boromir    Men    15
## 129                   Gandalf  Ainur    68
## 130                     Gimli  Dwarf    47
## 131                   Legolas    Elf     3
## 132                     Merry Hobbit    17
## 133                    Pippin Hobbit    10
## 134                       Sam Hobbit     3
## 135                   Aragorn    Men    30
## 136                   Boromir    Men    61
## 137                     Frodo Hobbit     6
## 138                   Gandalf  Ainur    18
## 139                     Gimli  Dwarf    19
## 140                   Legolas    Elf     8
## 141                   Saruman  Ainur    68
## 142                   Aragorn    Men    31
## 143                   Boromir    Men    31
## 144                     Frodo Hobbit    30
## 145                   Gandalf  Ainur   202
## 146                     Gimli  Dwarf    52
## 147                   Legolas    Elf     7
## 148                     Merry Hobbit     9
## 149                    Pippin Hobbit    11
## 150                       Sam Hobbit     7
## 151                     Frodo Hobbit    39
## 152                   Gandalf  Ainur   349
## 153                     Gimli  Dwarf     6
## 154                     Merry Hobbit     8
## 155                    Pippin Hobbit    10
## 156                       Sam Hobbit     7
## 157                   Aragorn    Men    22
## 158                   Boromir    Men     5
## 159                     Frodo Hobbit     8
## 160                   Gandalf  Ainur    89
## 161                     Gimli  Dwarf    37
## 162                   Legolas    Elf     8
## 163                       Sam Hobbit    13
## 164                   Aragorn    Men    45
## 165                   Boromir    Men    17
## 166                     Frodo Hobbit     4
## 167                   Gandalf  Ainur    83
## 168                     Gimli  Dwarf     7
## 169                   Legolas    Elf     4
## 170                   Aragorn    Men    26
## 171                   Boromir    Men    27
## 172                 Galadriel    Elf    19
## 173                     Gimli  Dwarf    84
## 174                    Haldir    Elf    51
## 175                   Legolas    Elf     7
## 176                       Sam Hobbit     2
## 177                   Aragorn    Men    16
## 178                   Boromir    Men   149
## 179                  Celeborn    Elf    61
## 180                 Galadriel    Elf   135
## 181                    Haldir    Elf    19
## 182                   Legolas    Elf    41
## 183                     Merry Hobbit     6
## 184                       Sam Hobbit    49
## 185                     Frodo Hobbit    36
## 186                 Galadriel    Elf   214
## 187                     Lurtz    Orc     1
## 188                   Saruman  Ainur    83
## 189                   Aragorn    Men    13
## 190                  Celeborn    Elf    99
## 191                 Galadriel    Elf   166
## 192                     Gimli  Dwarf    81
## 193                   Legolas    Elf    20
## 194                     Merry Hobbit     5
## 195                    Pippin Hobbit     1
## 196                       Sam Hobbit    13
## 197                   Aragorn    Men    64
## 198                   Boromir    Men   103
## 199                     Frodo Hobbit    16
## 200                       Sam Hobbit    37
## 201                   Aragorn    Men    79
## 202                   Boromir    Men   202
## 203                     Frodo Hobbit    54
## 204                     Gimli  Dwarf    48
## 205                   Legolas    Elf    31
## 206                     Merry Hobbit     2
## 207         Voice Of The Ring  Ainur     3
## 208                   Aragorn    Men     2
## 209                   Boromir    Men     2
## 210                   Legolas    Elf     6
## 211                     Lurtz    Orc     6
## 212                     Merry Hobbit    18
## 213                    Pippin Hobbit    17
## 214                       Sam Hobbit     2
## 215                   Aragorn    Men    72
## 216                   Boromir    Men    72
## 217                   Aragorn    Men   102
## 218                     Frodo Hobbit    59
## 219                   Gandalf  Ainur    34
## 220                     Gimli  Dwarf    12
## 221                   Legolas    Elf    15
## 222                       Sam Hobbit    50
## 223                   Boromir    Men     2
## 224                     Frodo Hobbit     9
## 225                   Gandalf  Ainur    39
## 226                       Sam Hobbit     5
## 227                     Frodo Hobbit    46
## 228                       Sam Hobbit    97
## 229                     Frodo Hobbit   123
## 230                    Gollum Gollum   147
## 231                       Sam Hobbit   181
## 232                   Smeagol Gollum    28
## 233                 Grishnakh    Orc    10
## 234                    Mauhur    Orc     2
## 235                     Merry Hobbit    19
## 236                    Pippin Hobbit    26
## 237                     Ugluk    Orc    51
## 238                   Aragorn    Men    59
## 239                     Gimli  Dwarf    35
## 240                   Legolas    Elf    25
## 241                   Eothain    Men     2
## 242                     Freda    Men    24
## 243                    Morwen    Men    37
## 244                       Orc    Orc    29
## 245                   Saruman  Ainur   187
## 246                  Wild Man    Men    11
## 247                     Eomer    Men    13
## 248             Rohan Warrior    Men    10
## 249                     Eomer    Men    88
## 250                     Eowyn    Men     8
## 251          Grima Wormtongue    Men    81
## 252                   Theoden    Men     3
## 253                     Gimli  Dwarf     6
## 254                   Legolas    Elf    13
## 255                 Grishnakh    Orc    44
## 256                   Legolas    Elf    10
## 257                     Merry Hobbit    68
## 258                       Orc    Orc    20
## 259                    Pippin Hobbit    14
## 260                     Ugluk    Orc    33
## 261                  Uruk-hai    Orc    13
## 262                   Aragorn    Men    68
## 263                     Eomer    Men   156
## 264                     Gimli  Dwarf    24
## 265                   Legolas    Elf     7
## 266                   Aragorn    Men    33
## 267                     Gimli  Dwarf    16
## 268                     Merry Hobbit     3
## 269                 Grishnakh    Orc    18
## 270                     Merry Hobbit    28
## 271                    Pippin Hobbit    36
## 272                 Treebeard    Ent    77
## 273                     Frodo Hobbit    54
## 274                    Gollum Gollum   304
## 275                       Sam Hobbit    69
## 276                   Aragorn    Men    68
## 277                   Gandalf  Ainur   298
## 278                     Gimli  Dwarf    73
## 279                   Legolas    Elf    63
## 280                     Merry Hobbit     4
## 281                 Treebeard    Ent   204
## 282                   Aragorn    Men     7
## 283                   Gandalf  Ainur   226
## 284                     Frodo Hobbit    39
## 285                    Gollum Gollum    93
## 286                       Sam Hobbit    68
## 287                     Merry Hobbit    63
## 288                    Pippin Hobbit   122
## 289                 Treebeard    Ent   113
## 290                   Aragorn    Men    18
## 291                     Eowyn    Men    28
## 292                   Gandalf  Ainur   151
## 293                     Gimli  Dwarf    15
## 294          Grima Wormtongue    Men   166
## 295                      Hama    Men    21
## 296                   Theoden    Men    56
## 297                     Eowyn    Men    24
## 298                   Gandalf  Ainur    28
## 299                   Theoden    Men    55
## 300                   Aragorn    Men    59
## 301                     Eowyn    Men    24
## 302                     Freda    Men     3
## 303                   Gandalf  Ainur   165
## 304                     Gimli  Dwarf    21
## 305                      Hama    Men    29
## 306                   Theoden    Men    49
## 307                   Aragorn    Men    22
## 308                     Eowyn    Men    36
## 309             Rohan Warrior    Men    13
## 310          Grima Wormtongue    Men    51
## 311                   Saruman  Ainur    68
## 312                   Theoden    Men    18
## 313                   Aragorn    Men    31
## 314                     Eowyn    Men    45
## 315          Grima Wormtongue    Men    52
## 316                   Saruman  Ainur     4
## 317                     Frodo Hobbit    81
## 318                       Sam Hobbit    87
## 319                    Gollum Gollum    73
## 320                   Smeagol Gollum    66
## 321                   Faramir    Men    76
## 322                     Frodo Hobbit    39
## 323                       Sam Hobbit    91
## 324                   Smeagol Gollum    99
## 325                   Aragorn    Men     3
## 326                     Gimli  Dwarf    68
## 327                   Aragorn    Men    33
## 328                     Eowyn    Men    76
## 329                     Gimli  Dwarf     6
## 330                   Theoden    Men    59
## 331                   Aragorn    Men    97
## 332                     Arwen    Elf   119
## 333                    Elrond    Elf    55
## 334                     Eowyn    Men    11
## 335                   Aragorn    Men     9
## 336                     Eowyn    Men    10
## 337                   Gamling    Men     5
## 338                     Gimli  Dwarf    45
## 339                      Hama    Men     3
## 340                   Legolas    Elf     5
## 341                     Snaga    Orc    10
## 342                   Theoden    Men    50
## 343                     Eowyn    Men    22
## 344                     Freda    Men     1
## 345                   Gamling    Men    14
## 346                     Gimli  Dwarf     4
## 347                    Morwen    Men     2
## 348              Rohan Maiden    Men    15
## 349             Rohan Warrior    Men    22
## 350                   Theoden    Men    49
## 351          Grima Wormtongue    Men    66
## 352                     Merry Hobbit     8
## 353                    Pippin Hobbit     9
## 354                   Saruman  Ainur    50
## 355                 Treebeard    Ent    37
## 356                     Arwen    Elf     8
## 357                     Arwen    Elf    14
## 358                    Elrond    Elf   188
## 359                 Galadriel    Elf   190
## 360                   Faramir    Men   143
## 361                     Frodo Hobbit    75
## 362                Gondor Man    Men    63
## 363                       Sam Hobbit     8
## 364                   Boromir    Men   132
## 365                     Crowd    Men     6
## 366                  Denethor    Men   250
## 367                   Faramir    Men    35
## 368                   Faramir    Men    92
## 369                     Frodo Hobbit    89
## 370                    Gollum Gollum    35
## 371                Gondor Man    Men    16
## 372                       Sam Hobbit    64
## 373                   Smeagol Gollum    55
## 374                   Aragorn    Men    69
## 375                   Gamling    Men     9
## 376                     Gimli  Dwarf    51
## 377                   Legolas    Elf     5
## 378              Rohan Maiden    Men     2
## 379                   Theoden    Men   206
## 380                     Merry Hobbit     6
## 381                 Treebeard    Ent    55
## 382                   Aragorn    Men    78
## 383                     Eowyn    Men    65
## 384                     Gimli  Dwarf    13
## 385                   Legolas    Elf    36
## 386             Rohan Warrior    Men    12
## 387                   Gamling    Men    30
## 388                   Theoden    Men    64
## 389                     Merry Hobbit    18
## 390                    Pippin Hobbit     7
## 391                 Treebeard    Ent    12
## 392                   Aragorn    Men    34
## 393                     Gimli  Dwarf    14
## 394                    Haldir    Elf    37
## 395                    Haleth    Men    23
## 396                   Legolas    Elf    24
## 397             Rohan Warrior    Men    17
## 398                   Theoden    Men     4
## 399                   Aragorn    Men    18
## 400                   Gamling    Men     1
## 401                     Gimli  Dwarf    50
## 402                   Legolas    Elf    37
## 403             Rohan Warrior    Men     1
## 404                   Theoden    Men     7
## 405                     Merry Hobbit    30
## 406                    Pippin Hobbit     5
## 407                 Treebeard    Ent    64
## 408                   Aragorn    Men    12
## 409                     Gimli  Dwarf     6
## 410                   Theoden    Men    17
## 411                     Merry Hobbit    58
## 412                    Pippin Hobbit    29
## 413                 Treebeard    Ent    42
## 414                   Aragorn    Men    31
## 415                   Gamling    Men     6
## 416                     Gimli  Dwarf    34
## 417                   Legolas    Elf     1
## 418             Rohan Warrior    Men    22
## 419                   Theoden    Men    58
## 420                     Merry Hobbit     6
## 421                    Pippin Hobbit    46
## 422                 Treebeard    Ent    64
## 423                   Faramir    Men     1
## 424                     Frodo Hobbit    23
## 425                Gondor Man    Men     6
## 426                     Merry Hobbit     5
## 427                    Pippin Hobbit     8
## 428                 Treebeard    Ent   105
## 429                   Faramir    Men    31
## 430                     Frodo Hobbit    15
## 431                Gondor Man    Men    20
## 432                       Sam Hobbit    53
## 433                   Aragorn    Men    73
## 434                     Eomer    Men     6
## 435                   Gamling    Men    20
## 436                   Gandalf  Ainur    21
## 437                     Gimli  Dwarf     5
## 438              Rohan Maiden    Men     7
## 439                   Theoden    Men    63
## 440                     Merry Hobbit     3
## 441                    Pippin Hobbit     1
## 442                 Treebeard    Ent    15
## 443                   Faramir    Men    16
## 444                     Frodo Hobbit    12
## 445                Gondor Man    Men    22
## 446                       Sam Hobbit   186
## 447                   Theoden    Men     4
## 448                     Eomer    Men    10
## 449                     Gimli  Dwarf    35
## 450                   Legolas    Elf     7
## 451                     Merry Hobbit    77
## 452                    Pippin Hobbit    56
## 453                   Faramir    Men    95
## 454                     Frodo Hobbit    18
## 455                    Gollum Gollum    32
## 456                       Sam Hobbit    54
## 457                     Frodo Hobbit    30
## 458                   Gandalf  Ainur    36
## 459                       Sam Hobbit    69
## 460                     Frodo Hobbit    11
## 461                    Gollum Gollum    75
## 462                       Sam Hobbit    12
## 463                   Smeagol Gollum    53
## 464                    Deagol Hobbit    13
## 465                    Gollum Gollum     3
## 466                   Smeagol Gollum    98
## 467                     Frodo Hobbit    18
## 468                    Gollum Gollum    41
## 469                       Sam Hobbit    77
## 470                   Gandalf  Ainur     1
## 471                     Gimli  Dwarf    22
## 472                     Merry Hobbit    36
## 473                    Pippin Hobbit    51
## 474                   Aragorn    Men     3
## 475                   Gandalf  Ainur   111
## 476                     Gimli  Dwarf    23
## 477          Grima Wormtongue    Men     2
## 478                   Saruman  Ainur   301
## 479                   Theoden    Men    98
## 480                 Treebeard    Ent    50
## 481                   Aragorn    Men    20
## 482                     Eomer    Men     4
## 483                     Eowyn    Men     8
## 484                   Gandalf  Ainur    15
## 485                     Gimli  Dwarf    40
## 486                   Legolas    Elf    21
## 487                     Merry Hobbit    78
## 488                    Pippin Hobbit    73
## 489             Rohan Warrior    Men     1
## 490                   Theoden    Men    52
## 491                     Frodo Hobbit    46
## 492                    Gollum Gollum   149
## 493                       Sam Hobbit    65
## 494                   Smeagol Gollum    83
## 495                   Aragorn    Men    13
## 496                     Eowyn    Men    50
## 497                   Aragorn    Men    20
## 498                   Gandalf  Ainur   255
## 499                   Legolas    Elf    22
## 500                     Merry Hobbit   135
## 501                    Pippin Hobbit   104
## 502                   Theoden    Men    22
## 503                    Elrond    Elf    36
## 504                    Figwit    Elf     7
## 505                     Arwen    Elf   100
## 506                    Elrond    Elf    30
## 507                  Denethor    Men   151
## 508                   Gandalf  Ainur   202
## 509                    Pippin Hobbit    36
## 510                   Gandalf  Ainur   268
## 511                    Pippin Hobbit    22
## 512                     Frodo Hobbit    30
## 513                    Gollum Gollum    13
## 514                       Sam Hobbit    56
## 515                   Gandalf  Ainur   163
## 516                Gondor Man    Men     2
## 517                    Pippin Hobbit    75
## 518                     Frodo Hobbit     8
## 519                   Gandalf  Ainur    20
## 520                    Gollum Gollum    50
## 521                       Sam Hobbit     5
## 522                     Frodo Hobbit     4
## 523                    Gollum Gollum    13
## 524                       Sam Hobbit    61
## 525                   Gandalf  Ainur    30
## 526                    Damrod    Men     3
## 527                   Faramir    Men    18
## 528                Gondor Man    Men     7
## 529                   Gothmog    Orc     6
## 530                    Madril    Men    28
## 531                   Gandalf  Ainur     5
## 532                Gondor Man    Men    10
## 533                   Aragorn    Men    18
## 534                     Eomer    Men    21
## 535                     Eowyn    Men    36
## 536                   Gamling    Men     4
## 537                     Gimli  Dwarf    15
## 538                   Legolas    Elf    19
## 539                     Merry Hobbit    16
## 540             Rohan Warrior    Men     3
## 541                   Theoden    Men    73
## 542                    Damrod    Men     1
## 543                   Faramir    Men    66
## 544                   Gandalf  Ainur    34
## 545                Gondor Man    Men    17
## 546                   Gothmog    Orc    13
## 547                    Irolas    Men    13
## 548                    Madril    Men     8
## 549                    Pippin Hobbit    15
## 550                  Denethor    Men   114
## 551                   Faramir    Men    72
## 552                    Gollum Gollum    76
## 553                       Sam Hobbit     8
## 554                   Gandalf  Ainur     9
## 555                Gondor Man    Men     9
## 556                   Gothmog    Orc     4
## 557                Witch King Nazgul    21
## 558                   Faramir    Men    80
## 559                    Pippin Hobbit    66
## 560                  Denethor    Men    89
## 561                   Faramir    Men    53
## 562                    Pippin Hobbit    32
## 563                     Frodo Hobbit    43
## 564                    Gollum Gollum    79
## 565                       Sam Hobbit   184
## 566                  Denethor    Men    20
## 567                   Faramir    Men    31
## 568                   Gandalf  Ainur    29
## 569                       Orc    Orc     5
## 570                    Pippin Hobbit    59
## 571                   Aragorn    Men    26
## 572                     Eomer    Men    89
## 573                     Eowyn    Men    56
## 574                     Gimli  Dwarf    12
## 575                  Grimhold    Men     9
## 576                   Legolas    Elf    21
## 577                     Merry Hobbit    12
## 578             Rohan Warrior    Men    30
## 579                   Theoden    Men    24
## 580                   Aragorn    Men    54
## 581                     Arwen    Elf    15
## 582                    Elrond    Elf   168
## 583             Rohan Warrior    Men     7
## 584                   Theoden    Men     4
## 585                   Aragorn    Men    42
## 586                     Eowyn    Men    32
## 587                   Gamling    Men    18
## 588                     Gimli  Dwarf    20
## 589                   Legolas    Elf     9
## 590             Rohan Warrior    Men    20
## 591                   Theoden    Men    16
## 592                     Eowyn    Men    10
## 593                   Theoden    Men    60
## 594                   Aragorn    Men     6
## 595                     Gimli  Dwarf    45
## 596                   Legolas    Elf   123
## 597                     Eomer    Men     8
## 598                     Eowyn    Men     3
## 599                     Merry Hobbit    21
## 600                   Theoden    Men    63
## 601                   Aragorn    Men    75
## 602                     Gimli  Dwarf    43
## 603          King Of The Dead   Dead    53
## 604                   Legolas    Elf    32
## 605                  Denethor    Men    40
## 606                   Gandalf  Ainur    81
## 607                Gondor Man    Men    19
## 608                   Gothmog    Orc    46
## 609                    Irolas    Men     7
## 610                       Orc    Orc    25
## 611                    Pippin Hobbit    15
## 612                   Aragorn    Men    21
## 613                     Boson    Men     7
## 614                     Gimli  Dwarf    14
## 615                 Mercenary    Men     6
## 616                     Frodo Hobbit    60
## 617                 Galadriel    Elf    51
## 618                    Gollum Gollum    64
## 619                       Sam Hobbit     1
## 620                   Smeagol Gollum    26
## 621                     Eomer    Men    22
## 622                     Eowyn    Men    10
## 623                     Merry Hobbit    83
## 624                   Theoden    Men    13
## 625                   Gandalf  Ainur     5
## 626                  Denethor    Men    68
## 627                   Gandalf  Ainur    21
## 628                       Orc    Orc    15
## 629                       Sam Hobbit    48
## 630                   Shagrat    Orc    55
## 631                  Denethor    Men    36
## 632                Gondor Man    Men    10
## 633                    Pippin Hobbit    17
## 634                   Gandalf  Ainur    48
## 635                Gondor Man    Men     7
## 636                   Gothmog    Orc     9
## 637                    Pippin Hobbit    13
## 638                Witch King Nazgul    24
## 639                     Eomer    Men     2
## 640                     Eowyn    Men    17
## 641                   Gothmog    Orc    15
## 642                     Merry Hobbit     2
## 643                   Theoden    Men    71
## 644                  Denethor    Men    42
## 645                   Gandalf  Ainur     9
## 646                    Pippin Hobbit     2
## 647                     Eomer    Men     9
## 648                     Eowyn    Men     8
## 649             Rohan Warrior    Men     3
## 650                   Theoden    Men    26
## 651                   Gandalf  Ainur    54
## 652                    Pippin Hobbit    17
## 653                     Eowyn    Men     8
## 654                   Theoden    Men     5
## 655                Witch King Nazgul    13
## 656                     Gimli  Dwarf    12
## 657                       Orc    Orc    19
## 658                     Eowyn    Men     4
## 659                Witch King Nazgul     9
## 660                   Aragorn    Men     1
## 661                     Eowyn    Men     1
## 662                     Gimli  Dwarf     6
## 663                   Legolas    Elf     6
## 664                       Orc    Orc     5
## 665                     Eowyn    Men     8
## 666                   Theoden    Men    38
## 667                   Aragorn    Men     9
## 668                     Gimli  Dwarf    15
## 669          King Of The Dead   Dead     7
## 670                     Eomer    Men     3
## 671                    Pippin Hobbit     1
## 672                     Merry Hobbit    11
## 673                    Pippin Hobbit    16
## 674                     Frodo Hobbit    64
## 675                    Grobag    Orc    23
## 676                       Sam Hobbit    96
## 677                   Shagrat    Orc    35
## 678                   Aragorn    Men    82
## 679                     Eomer    Men     8
## 680                   Gandalf  Ainur    59
## 681                     Gimli  Dwarf    24
## 682                   Legolas    Elf     2
## 683                   Aragorn    Men    17
## 684                     Eowyn    Men    17
## 685                   Faramir    Men    17
## 686                     Frodo Hobbit    16
## 687                       Orc    Orc   104
## 688                       Sam Hobbit    46
## 689                     Frodo Hobbit    30
## 690                       Sam Hobbit    56
## 691                   Aragorn    Men    23
## 692                   Gandalf  Ainur    32
## 693                     Gimli  Dwarf     5
## 694                     Merry Hobbit     1
## 695           Mouth Of Sauron    Orc    87
## 696                    Pippin Hobbit     5
## 697                   Aragorn    Men   103
## 698                     Gimli  Dwarf    16
## 699                   Legolas    Elf     8
## 700                       Sam Hobbit    16
## 701                     Frodo Hobbit    44
## 702                       Sam Hobbit    85
## 703                   Aragorn    Men     2
## 704           Voice Of Sauron  Ainur     2
## 705                     Frodo Hobbit     9
## 706                    Gollum Gollum    17
## 707                       Sam Hobbit    10
## 708                    Pippin Hobbit     6
## 709                     Frodo Hobbit     7
## 710                    Gollum Gollum     5
## 711                       Sam Hobbit    38
## 712                     Merry Hobbit     2
## 713                    Pippin Hobbit     1
## 714                     Frodo Hobbit    37
## 715                       Sam Hobbit    31
## 716                     Frodo Hobbit     4
## 717                     Gimli  Dwarf     1
## 718                     Merry Hobbit     1
## 719                   Aragorn    Men    45
## 720                   Gandalf  Ainur    11
## 721                     Frodo Hobbit    98
## 722                   Hobbits Hobbit     4
## 723                    Pippin Hobbit     2
## 724                     Rosie Hobbit     2
## 725                       Sam Hobbit    27
## 726                     Bilbo Hobbit    56
## 727                    Elrond    Elf     6
## 728                     Frodo Hobbit   132
## 729                 Galadriel    Elf    17
## 730                   Gandalf  Ainur    42
## 731                       Sam Hobbit    14
```

Reorder Film factor levels


```r
old_levels <- levels(ldcs2$Film)
j_order <- sapply(c("Fellowship", "Towers", "Return"),
				  function(x) grep(x, old_levels))
new_levels <- old_levels[j_order]
```

Clean up dataset: apply new factor levels to Film, change name of races, drop less frequent races, arrange based on race,film, words


```r
lotr_data_clean <- ldcs2 %>% 
	mutate("Film" = factor(as.character(Film), new_levels),
		   "Race" = plyr::revalue(Race, c(Ainur="Wizard", Men="Man"))) %>% 
	filter(!(Race %in% c("Gollum", "Orc", "Ent", "Dead", "Nazgul"))) %>% 
	mutate(Race = reorder(Race, Words, sum)) %>% 
	arrange(Race,Film, Character, Words) %>% 
	droplevels
glimpse(lotr_data_clean)
```

```
## Observations: 653
## Variables: 6
## $ Film           <fctr> The Fellowship Of The Ring, The Fellowship Of ...
## $ Chapter_Number <fctr> 34, 36, 46, 32, 35, 27, 31, 43, 33, 41, 37, 35...
## $ Chapter_Name   <fctr>  A Journey In The Dark,  The Bridge Of Khazad-...
## $ Character      <fctr> Gimli, Gimli, Gimli, Gimli, Gimli, Gimli, Giml...
## $ Race           <fctr> Dwarf, Dwarf, Dwarf, Dwarf, Dwarf, Dwarf, Dwar...
## $ Words          <int> 6, 7, 12, 19, 37, 38, 47, 48, 52, 81, 84, 4, 5,...
```

Here is a plot about which race does the most talking by film


```r
plot1 <- lotr_data_clean %>% 
	ggplot(aes(Race, Words)) + 
	geom_col() +
	facet_wrap(~Film) +
	labs(y="Total Words Spoken") 
print(plot1)
```

![](Step04-lotrreport_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

the pre-made plot from above that I am embedding in the compiled document.


# The Nine Companions

Filter to show total words spoken by the Nine Companions


```r
fellowship <- c("Gandalf", "Aragorn", "Merry", "Pippin", "Frodo", "Sam", "Gimli", "Legolas", "Boromir")
(characterwords <- lotr_data %>% 
	filter(Character %in% fellowship) %>% 
	group_by(Character, Film) %>% 
	summarize(sum(Words)))
```

```
## # A tibble: 26 x 3
## # Groups:   Character [?]
##    Character                       Film `sum(Words)`
##       <fctr>                     <fctr>        <int>
##  1   Aragorn The Fellowship Of The Ring          920
##  2   Aragorn     The Return Of The King          580
##  3   Aragorn             The Two Towers          822
##  4   Boromir The Fellowship Of The Ring          943
##  5   Boromir             The Two Towers          134
##  6     Frodo The Fellowship Of The Ring          967
##  7     Frodo     The Return Of The King          650
##  8     Frodo             The Two Towers          664
##  9   Gandalf The Fellowship Of The Ring         2360
## 10   Gandalf     The Return Of The King         1504
## # ... with 16 more rows
```

For each Film, show a plot of words by fellowship member


```r
plyr::d_ply(characterwords, ~Film, function(p){
	the_film <- p$Film[1]
	R <- ggplot(p, aes(Character, `sum(Words)`))+ 
		geom_col() +
		theme(axis.text.x=element_text (angle=270)) +
		labs(y="Total Words Spoken", x= "Nine Companions")+
		ggtitle(the_film)
	print(R)
})
```

![](Step04-lotrreport_files/figure-html/unnamed-chunk-8-1.png)<!-- -->![](Step04-lotrreport_files/figure-html/unnamed-chunk-8-2.png)<!-- -->![](Step04-lotrreport_files/figure-html/unnamed-chunk-8-3.png)<!-- -->


