local bit = {}

if jit then
    bit = require("bit")
else
    bit.band = function(a, b)
        return a & b
    end
    bit.bor = function(a, b)
        return a | b
    end
    bit.bxor = function(a, b)
        return a ~ b
    end
    bit.lshift = function(a, b)
        return a << b
    end
    bit.rshift = function(a, b)
        return a >> b
    end
    bit.bandnot = function(a, b)
        return a & ~b
    end
    bit.bornot = function(a, b)
        return a | ~b
    end
    bit.bxornot = function(a, b)
        return a ~ ~b
    end
    bit.lshiftnot = function(a, b)
        return a << ~b
    end
    bit.rshiftnot = function(a, b)
        return a >> ~b
    end
end

local M = {}

function M.truth_table(vars, expr_func)
    local n = #vars
    local table_rows = {}

    -- Header row
    local header = {}
    for _, var in ipairs(vars) do
        table.insert(header, var)
    end
    table.insert(header, "Result")
    table.insert(table_rows, header)

    -- Genrate all possible combinations of variable values
    for i = 0, (2 ^ n) - 1 do
        local row = {}
        local values = {}

        for j = 0, n - 1 do
            local value = (bit.band(i, j) == 0)
            table.insert(row, tostring(value))
            values[j + 1] = value
        end

        -- Calculate the result using the expression
        local result = expr_func(table.unpack(values))
        table.insert(row, tostring(result))
        table.insert(table_rows, row)
    end

    return table_rows
end

function M.print_truth_table(table_rows)
    local col_widths = {}

    for i, row in ipairs(table_rows) do
        for j, cell in ipairs(row) do
            col_widths[j] = math.max(col_widths[j] or 0, #cell)
        end
    end

    -- Print header
    local header = table_rows[1]
    local separator = ""
    local header_str = ""

    for j, cell in ipairs(header) do
        local width = col_widths[j]
        separator = separator .. string.rep("-", width + 2) .. "+"
        header_str = header_str .. " " .. string.format("%-" .. width, cell) .. " |"
    end

    separator = "+" .. separator
    header_str = "|" .. header_str

    print(separator)
    print(header_str)
    print(separator)

    -- Print data rows
    for i = 2, #table_rows do
        local row = table_rows[i]
        local row_str = "|"

        for j, cell in ipairs(row) do
            local width = col_widths[j]
            row_str = row_str .. " " .. string.format("%-" .. width .. "s", cell) .. " |"
        end

        print(row_str)
    end

    print(separator)
end

function M.AND(a, b)
    return a and b
end

function M.OR(a, b)
    return a or b
end

function M.NOT(a)
    return not a
end

function M.XOR(a, b)
    return a ~= b
end

function M.IMPLIES(a, b)
    return (not a) or b
end

function M.EQUIVALENT(a, b)
    return a == b
end

return M
