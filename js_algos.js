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

console.log(validTime(41, 4));
