var init = true;
var sourceGridCdr =
{
    datatype: "json",
    type: 'POST',
    datafields:
        [
            { name: 'extNumber', type: 'string' },
            { name: 'extName', type: 'string' },
            { name: 'datum', type: 'date' },
            { name: 'vrijeme', type: 'date' },
            { name: 'pozivaoc', type: 'string' },
            { name: 'pozivani', type: 'string' },
            { name: 'pozivTip', type: 'string' },
            { name: 'pozivStatus', type: 'string' },
            { name: 'duration', type: 'string' },
            { name: 'bilSec', type: 'string' },
            { name: 'durationSec', type: 'int' },
            { name: 'bilSecSec', type: 'int' },
            { name: 'id', type: 'int' }
        ],
    id: 'id',
    cache: false,
    formatData: function (data) {
        return {
            'jsonData': JSON.stringify(data),
            'init' : init

        };
    },
    url: '../../Reports/gridCdr',
    filter: function (data) {
        //console.log(data); data je array koji možemo checkirai na lengt kako bi mogli vidjti imamo li fitler
        // update the grid and send a request to the server.
        //return false; //return false ne osvježava grid 
        if (data.length == 0) {
            if (confirm('Pokušavate dobiti izvještaj o kompletnoj bazi podataka.\nTražite izvještaj bez postavljenih filtera.\nOva opercaija može potrajti, optertiti server i opteretiti vaš računar\nDa li želite nastaviti sa zahtjevom za kompletnu bazu podataka ')) {
                $("#gridCdr").jqxGrid('updatebounddata', 'filter');
            } else {
                $('#gridCdr').jqxGrid('clear');
            }
        }
        else {
            $("#gridCdr").jqxGrid('updatebounddata', 'filter');
        };
        
    }
};

var dataAdapterGridCdr = new $.jqx.dataAdapter(sourceGridCdr);
function initialFilterGridCdr() {
    var filtergroup = new $.jqx.filter();
    var filter_or_operator = 1;

    var filtervalue = new Date();

    var filterOd = filtergroup.createfilter('datefilter', filtervalue, 'GREATER_THAN_OR_EQUAL');
    var filterDo = filtergroup.createfilter('datefilter', filtervalue, 'LESS_THAN_OR_EQUAL');

    filtergroup.addfilter(filter_or_operator, filterOd);
    filtergroup.addfilter(filter_or_operator, filterDo);
    $("#gridCdr").jqxGrid('addfilter', 'datum', filtergroup);
    $("#gridCdr").jqxGrid('applyfilters');
}

function initGridCdr() {

    $("#gridCdr").jqxGrid({
        source: dataAdapterGridCdr
    });


    init = false;

    var ektenzije = [];
    $.ajax({
        url: "../../Reports/dostupneEksteznije",
        type: "GET",
        dataType: "json",
        async: false,
        success: function (data) {
            ektenzije = data;
        }
    });
    $("#gridCdr").jqxGrid('setcolumnproperty', 'vrijeme', 'filterable', false);
    $("#gridCdr").jqxGrid('setcolumnproperty', 'duration', 'filterable', false);
    $("#gridCdr").jqxGrid('setcolumnproperty', 'bilSec', 'filterable', false);
    $("#gridCdr").jqxGrid('setcolumnproperty', 'extNumber', 'filteritems', ektenzije);
    $("#gridCdr").jqxGrid('setcolumnproperty', 'pozivTip', 'filteritems', ['Odlazni', 'Dolazni','Interni','Ostali']); //'Ugovorno sa kontrolom odogode' //Za sada imamo samo 2x tipa
    $("#gridCdr").jqxGrid('setcolumnproperty', 'pozivStatus', 'filteritems', ['ANSWERED','BUSY','NO ANSWER', 'FAILED']); //'Ugovorno sa kontrolom odogode' //Za sada imamo samo 2x tipa
    setTimeout(function () {
        initialFilterGridCdr();
    }, 200);
    
}

function getGridCdr(selectedValue) {
    //$("#gridEngine").jqxGrid('exportdata', selectedValue, 'RobotReport', true, null, '/GridExport');
    $("#gridCdr").jqxGrid('exportdata', selectedValue, 'CdrReport', true, null, false, '../../Reports/GridExport');
    //var data = $("#gridEngine").jqxGrid('exportdata', selectedValue);
}


$(document).ready(function ready() {
    initGridCdr();
});