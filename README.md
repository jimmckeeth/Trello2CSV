# Trello2CSV
Extract data from Trello to a CSV file using Delphi &amp; FireDAC.

To handle descriptions (or any string) longer than 255 bytes

* Make a copy of REST.Response.Adapter.pas into your project folder
* And add it to your project. 
* On line 542 (in the 10.0 Seattle release) change it from

    LFieldDef.Size := 255;

to

    LFieldDef.Size := MaxInt;

* Enjoy much longer description strings.

If you don't want this workaround, then remove REST.Response.Adapter.pas from your project.