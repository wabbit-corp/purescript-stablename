"use strict";

// module Effect.StableName

var   nextUniqueId = 0;
const stableNames  = new WeakMap();

exports.eqStableName = function (x) {
  return function(y) {
    return x === y;
  };
};

exports.hashStableName = function (x) {
  return stableNames[x];
};

exports.makeStableName = function (x) {
  return function () {
    if (x in stableNames) return x;
    nextUniqueId = nextUniqueId + 1;
    stableNames[x] = nextUniqueId;
    return x;
  };
};