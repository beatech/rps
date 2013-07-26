function scoreSort(position) {
  $("#SP tbody").html(
    $("#SP tbody tr").sort(function(a, b) {
      return parseFloat(scoreOfTr($(a), position)) > parseFloat(scoreOfTr($(b), position)) ? -1 : 1;
    })
  );
  $("#DP tbody").html(
    $("#DP tbody tr").sort(function(a, b) {
      return parseFloat(scoreOfTr($(a), position)) > parseFloat(scoreOfTr($(b), position)) ? -1 : 1;
    })
  );
  refreshRanking();
}

function clearSort(position) {
  $("#SP tbody").html(
    $("#SP tbody tr").sort(function(a, b) {
      return parseFloat(clearOfTr($(a), position)) > parseFloat(clearOfTr($(b), position)) ? -1 : 1;
    })
  );
  $("#DP tbody").html(
    $("#DP tbody tr").sort(function(a, b) {
      return parseFloat(clearOfTr($(a), position)) > parseFloat(clearOfTr($(b), position)) ? -1 : 1;
    })
  );
  refreshRanking();
}

function musicSort(position) {
  $("#SP tbody").html(
    $("#SP tbody tr").sort(function(a, b) {
      return musicOfTr($(a), position) > musicOfTr($(b), position) ? -1 : 1;
    })
  );
  $("#DP tbody").html(
    $("#DP tbody tr").sort(function(a, b) {
      return musicOfTr($(a), position) > musicOfTr($(b), position) ? -1 : 1;
    })
  );  
  refreshRanking();
}

function refreshRanking() {
  var count = $("#SP tbody tr").length;
  var i;

  var spTr = $("#SP tbody tr").first();
  var dpTr = $("#DP tbody tr").first();
  for (i = 0; i < count; i++) {
    spTr.children().eq(0).html((i + 1).toString());
    dpTr.children().eq(0).html((i + 1).toString());
    spTr = spTr.next();
    dpTr = dpTr.next();
  }
}

function clearOfTr(tr, position) {
  return tr.children().eq(position).children().filter(".clear").children().first().html();
}

function scoreOfTr(tr, position) {
  return tr.children().eq(position).children().filter(".score").html();
}

function musicOfTr(tr, position) {
  return tr.children().eq(position).children().filter(".clear").html();
}

$(window).load(function() {
	scoreSort(7);
});
