// An arrry of objects, {start time => endtime}, input = {starttime, endtime}, find if input is a valid time

var objects = [{start: 10, end: 40}, {start: 43, end: 48}, {start: 2, end: 5}];

function validTime(start, end) {
  for (var i = 0; i < objects.length; i++) {
    if (start > objects[i].start && start < objects[i].end) {
      return false;
    } else if (end > objects[i].start && end < objects[i].end) {
      return false;
    }
  }
  return true;
}


var array = [3, 4, 1, 3, 1, 7, 2, 2, 4];

function nonRepeating(a) {
  var element = 0;
  for (var i = 0; i < a.length; i++) {
    element ^= a[i];
  }
  return element;
}


/*
##The Problem

*Reconciliation* is a term Addepar uses for a set of correctness and
consistency measures applied to the data we receive and use in financial
calculations.

One of the most common reconciliation checks is called *unit reconciliation*,
which answers the question, "does the tranasction history add up to the number
of shares the bank says I have?". For example, if the bank said I had 100
shares of Apple at the end of yesterday, and I bought 20 shares of Apple today,
then we expect the bank to report 120 shares at the end of today. This
surprisingly isn't always the case! The bank may send incomplete data, we may
be parsing it incorrectly, or there may be events like corporate actions or
trade settlement lag that cause an inconsistency.

Unit reconciliation is very important because numbers that don't add up
shouldn't be trusted for any metrics.

##The Input

`recon.in` has three sections:

`D0-POS` describes the positions in the account at the end of Day 0. Each
record is a space-separated pair of Symbol and Shares. For example, "AAPL 10"
means 10 shares of AAPL were held at the end of Day 0, and "Cash 122.16"
means we had $122.16 in the account at the end of Day 0.

`D1-TRN` describes the transactions that occured in the account on Day 1.
Each record is a space-separated collection of four items:
Symbol, Transaction Code, Shares, and Total Value. For example,
"AAPL BY 10 6123.21" means 10 shares of AAPL were bought for a total cost of
$6123.21.

`D1-POS` describes the positions in the account at the end of Day 1, and has
the same format as `D0-POS`.

##The Output

The objective is to write a program that produces `recon.out`. Each line should
be a space-separated record indicating a position that fails unit
reconciliation. For example, "AAPL 10" means that the reported shares of AAPL
in `D1-POS` is 10 higher than expected based on the transactions.

##Assumptions

`BY` and `SL` are the only currently known transaction codes. Can you design
a solution that easily extends to others?

Transactions have an implied effect on the cash balance.
*/

/*
D0-POS
AAPL 100
GOOG 200
Cash 10

D1-TRN
AAPL SL 50 30000
GOOG BY 10 10000

D1-POS
AAPL 50
GOOG 220
Cash 20000
*/

var d0Pos = "AAPL 100 GOOG 200 Cash 10000";
var d1Trn = "AAPL SL 50 30000 GOOG BY 10 10000";
var d1Pos = "AAPL 50 GOOG 220 Cash 20000";

function parseTransactions(tranString) {
  var codes = {BY: [1, -1], SL: [-1, 1]};
  var result = {Cash: 0};
  var trans = tranString.split(" ");
  while (trans.length !== 0) {
    result[trans[0]] = codes[trans[1]][0] * trans[2];
    result.Cash += codes[trans[1]][1] * trans[3];
    trans.splice(0, 4);
  }
  return result;
}

function parsePossessions(posString) {
  var pos = posString.split(" ");
  var result = {};
  while (pos.length !== 0) {
    result[pos[0]] = parseInt(pos[1]);
    pos.splice(0, 2);
  }
  return result;
}

function reconAssets(day0Pos, day1Trans, day1Pos) {
  var parsedTrans = parseTransactions(day1Trans);
  var parsedDay0 = parsePossessions(day0Pos);
  var parsedDay1 = parsePossessions(day1Pos);

  var testTrans = parsedDay0;
  for (var key in parsedTrans) {
    testTrans[key] = parsedDay0[key] + parsedTrans[key];
  }

  var result = "";
  for (var i in parsedDay1) {
    var diff;
    if (testTrans[i] === null) {
      diff = 0;
    } else {
      diff = testTrans[i];
    }
    if (parsedDay1[i] - testTrans[i] !== 0) {
      result += i + " " + (parsedDay1[i] - testTrans[i]) + " ";
    }
  }
  return result;
}


function spiralDiagSum(num) {
  var sum = 1;
  currentNum = 1;
  for (var i = 2; i < num; i += 2) {
    for (var j = 0; j < 4; j++) {
      currentNum = currentNum + i;
      sum = sum + currentNum;
    }
  }
  return (sum);
}


function leastDistanceWords(words, word1, word2) {
  var lastSeenWord1 = -1;
  var lastSeenWord2 = -1;
  var min = words.length;
  var distance;

  for (var i = 0; i < words.length; i++) {
    var currentWord = words[i];

    if (currentWord === word1) {
      lastSeenWord1 = i;

      distance = lastSeenWord1 - lastSeenWord2;
      if (min > distance && lastSeenWord2 !== -1) {
        min = distance;
      }
    } else if (currentWord === word2) {
      lastSeenWord2 = i;

      distance = lastSeenWord2 - lastSeenWord1;
      if (min > distance && lastSeenWord1 !== -1) {
        min = distance;
      }
    }
  }

  return min;
}

var matrix = [[-1,2,-3,4,5],
              [4,3,-5,2,-8],
              [-1,-5,3,4,2],
              [-4,2,4,-7,7],
              [2,-3,8,-9,3]];
function sumMatrix(matrix) {
  var sum = 0;
  for (var i = 0; i < matrix.length; i++) {
    sum += matrix[i].reduce((prev, curr) => prev + curr);
  }
  return sum;
}

// unfinished
function largestSumSubmatrix(matrix, currentLargestSum, currentLargestMatrix) {
  var size = matrix[0].length;
  if (size === 0) {
    return matrix;
  }

  var sum = sumMatrix(matrix);
  if (currentLargestSum === null || currentLargest < sum) {
    currentLargestSum = sum;
    currentLargestMatrix = matrix;
  }


}
