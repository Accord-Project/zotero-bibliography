   //function to read a csv
    function CSVToArray( strData, strDelimiter ){
        strDelimiter = (strDelimiter || ",");

        var objPattern = new RegExp(
            (
                "(\\" + strDelimiter + "|\\r?\\n|\\r|^)" +

                "(?:\"([^\"]*(?:\"\"[^\"]*)*)\"|" +

                "([^\"\\" + strDelimiter + "\\r\\n]*))"
            ),
            "gi"
            );
        var arrData = [[]];
        var arrMatches = null;
        while (arrMatches = objPattern.exec( strData )){
            var strMatchedDelimiter = arrMatches[ 1 ];
            if (
                strMatchedDelimiter.length &&
                strMatchedDelimiter !== strDelimiter
                ){
                arrData.push( [] );
            }
            var strMatchedValue;
            if (arrMatches[ 2 ]){
                strMatchedValue = arrMatches[ 2 ].replace(
                    new RegExp( "\"\"", "g" ),
                    "\""
                    );
            } else {
                strMatchedValue = arrMatches[ 3 ];
            }
            arrData[ arrData.length - 1 ].push( strMatchedValue );
        }
        return( arrData );
    }
    
var path = '/home/boyan/Desktop/tags_refined.csv';
var data = await Zotero.File.getContentsAsync(path);
data = CSVToArray(data,',')
// grab for example the last tag and replace it with the value in the right column
var last_tag = data[736][0]
var last_tag_new = data[736][1]
// select the current library(i.e. where you place your cursor)
var libraryID = ZoteroPane.getSelectedLibraryID();
Zotero.Tags.rename(libraryID,last_tag,last_tag_new)

return "done"
