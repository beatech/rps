function integerSort(position, tableId) {
  $("#" + tableId + " tbody").html(
    $("#" + tableId + " tbody tr").sort(function(a, b) {
      var a_value = parseInt(valueOfTr($(a), position));
      var b_value = parseInt(valueOfTr($(b), position));
      if (isNaN(a_value)) a_value = 0;
      if (isNaN(b_value)) b_value = 0;
      return a_value > b_value ? -1 : 1;
    })
  );
}

function floatSort(position, tableId) {
  $("#" + tableId + " tbody").html(
    $("#" + tableId + " tbody tr").sort(function(a, b) {
      var a_value = parseFloat(valueOfTr($(a), position));
      var b_value = parseFloat(valueOfTr($(b), position));
      if (isNaN(a_value)) a_value = 0;
      if (isNaN(b_value)) b_value = 0;
      return a_value > b_value ? -1 : 1;
    })
  );
}

function alphabetSort(position, tableId) {
  $("#" + tableId + " tbody").html(
    $("#" + tableId + " tbody tr").sort(function(a, b) {
      var a_value = valueOfTr($(a), position);
      var b_value = valueOfTr($(b), position);
      return a_value > b_value ? 1 : -1;
    })
  );
}

function clearLevel(lamp) {
  var clearLevel = 0;
  if (lamp.indexOf("-",0) > -1) clearLevel = 0;
  if (lamp.indexOf("F",0) > -1) clearLevel = 1;
  if (lamp.indexOf("A",0) > -1) clearLevel = 2;
  if (lamp.indexOf("E",0) > -1) clearLevel = 3;
  if (lamp.indexOf("C",0) > -1) clearLevel = 4;
  if (lamp.indexOf("H",0) > -1) clearLevel = 5;
  if (lamp.indexOf("EXH",0) > -1) clearLevel = 6;
  if (lamp.indexOf("FC",0) > -1) clearLevel = 7;
  return clearLevel;
}

function clearSort(position, tableId) {
  $("#" + tableId + " tbody").html(
    $("#" + tableId + " tbody tr").sort(function(a, b) {
      var a_value = clearLevel(valueOfTr($(a), position));
      var b_value = clearLevel(valueOfTr($(b), position));
      return a_value > b_value ? -1 : 1;
    })
  );
}

function valueOfTr(tr, position) {
  return tr.children().eq(position).html();
}

$(window).load(function() {
  ;
});
