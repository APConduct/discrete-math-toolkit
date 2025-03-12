package.path = package.path .. ";./src/?.lua;./src/?/init.lua"

local discrete_math = {
    Set = require "set",
    NumberTheory = require "number_theory",
    Graph = require("graph"),
    graph_theory = require("graph_theory"),
    Logic = require("logic"),
    relations = require("relations"),
    Sequence = require("sequence"),
    combinatorics = require("combinatorics")
}

return discrete_math
