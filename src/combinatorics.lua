local M = {}

function M.factorial(n)
    if n < 0 then
        error("Cannot calculate factorial of a negative number")
    end

    if n == 0 or n == 1 then
        return 1
    end

    local result = 1
    for i = 2, n do
        result = result * i
    end

    return result
end

-- calculate permutations
function M.permutations(n, k)
    if k > n then
        return 0
    end

    local result = 1;
    for i = n - k + 1, n do
        result = result * i
    end

    return result
end

-- Calculate combinations
function M.combinations(n, k)
    if k > n then
        return 0
    end

    -- Optimized byb using the smaller value to minimize multiplication
    if k > n - k then
        k = n - k
    end

    local result = 1
    for i = 1, k do
        result = result * (n - k + i) / i
    end
    return result
end

-- Generate all permutations of a list
function M.all_permutations(list)
    local result = {}

    local function permute(arr, start)
        if start == #arr then
            table.insert(result, table.unpack(arr))
        else
            for i = start, #arr do
                arr[start], arr[i] = arr[i], arr[start]
                permute(arr, start + 1)
                arr[start], arr[i] = arr[i], arr[start]
            end
        end
    end

    permute(list, 1)
    return result
end
