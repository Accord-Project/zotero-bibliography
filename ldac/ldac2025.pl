#!perl -wp0
s{ *<li style="margin-left: 25px;">
   *    <b>(.*)</b>
   *    <br/>(.*)
   *    <br/><a href="(files/papers/(LDAC2025_paper_)?(.*).pdf)">article</a>
   *    <br/><a href="(.*)">presentation</a>
   *</li>}
  {\@InProceedings{LDAC_2025_$5,
  title        = {$1},
  author       = {$2},
  booktitle    = {Linked Data in Architecture and Construction (LDAC 2025)},
  year         = 2025,
  month        = jul,
  url          = {https://linkedbuildingdata.net/ldac2025/$3},
  date         = {2025-07},
  address      = {Porto, Portugal},
  annotation   = {Presentation: https://linkedbuildingdata.net/ldac2025/$6}
}
}g;

s{ *<li style="margin-left: 25px;">
   *    <b>(.*)</b>
   *    <br/>(.*)
   *    <br/><a href="(files/papers/(LDAC2025_paper_)?(.*).pdf)">article</a>
   *</li>}
  {\@InProceedings{LDAC_2025_$5,
  title        = {$1},
  author       = {$2},
  booktitle    = {Linked Data in Architecture and Construction (LDAC 2025)},
  year         = 2025,
  month        = jul,
  url          = {https://linkedbuildingdata.net/ldac2025/$3},
  date         = {2025-07},
  address      = {Porto, Portugal}
}
}g;

s{ *(<!--)?<li style="margin-left: 25px;">
   *    <b>(.*)</b>
   *    <br/>(.*)
   *    <br/><a href="(files/posters/LDAC2025_(Poster_.*)_final.pdf)">extended abstract</a>
   *</li>(-->)?}
  {\@InProceedings{LDAC_2025_$5,
  title        = {$2},
  author       = {$3},
  booktitle    = {Linked Data in Architecture and Construction (LDAC 2025)},
  year         = 2025,
  month        = jul,
  url          = {https://linkedbuildingdata.net/ldac2025/$4},
  date         = {2025-07},
  address      = {Porto, Portugal},
  annotation   = {type: extended abstract}
}
}g;

s{ *<li style="margin-left: 25px;">
   *    <b>(.*)</b>
   *    <br/>(.*)
   *</li>}
  {\@InProceedings{LDAC_2025_Poster_xx,
  title        = {$1},
  author       = {$2},
  booktitle    = {Linked Data in Architecture and Construction (LDAC 2025)},
  year         = 2025,
  month        = jul,
  date         = {2025-07},
  address      = {Porto, Portugal},
  annotation   = {type: extended abstract}
}
}g;

# in "author": replace ", " with " and "
do {} while s{^(  author[^\}]+?), }{$1 and }m;
