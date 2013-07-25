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

scoreSort(7);
