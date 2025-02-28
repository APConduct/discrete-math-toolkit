local M = {}

M.__index = M

-- Create new Set from a list
-- @constructor
function M.new(list)
    local set = {}
    for _, value in ipairs(list) do
        set[value] = true
    end
    setmetatable(set, M)
    return set
end

function M:__tostring()
    --[[local list = M.to_list(set)
    table.sort(list)
    return "{" .. table.concat(list, ", ") .. "}"]]
    local Elemments = {}
    for e, _ in pairs(self) do table.insert(Elemments, e, _) end
    table.sort(Elemments)
    return "{" .. table.concat(Elemments, ", ") .. "}"
end

function M:__len()
    local count = 0
    for _ in pairs(self) do count = count + 1 end
    return count
end

function M:__eq(other)
    if self == other then return true end
    if not other or type(other) ~= "table" then return false end
    if #self ~= #other then return false end
    for k in pairs(self) do
        if not other[k] then return false end
    end
    return true
end

function M:contains(element)
    -- return self[value] ~= nil
    return self.elements[element] == true
end

function M:add(element)
    self.elements[element] = true
end

function M:remove(element)
    self.elements[element] = nil
end

function M:clear()
    self.elements = {}
end

function M:size()
    local count = 0
    for _ in pairs(self) do count = count + 1 end
    return count
end

function M:subset(other)
    for k in pairs(self) do
        if not other[k] then return false end
    end
    return true
end

function M:superset(other)
    for k in pairs(other) do
        if not self[k] then return false end
    end
    return true
end

function M:disjoint(other)
    for k in pairs(self) do
        if other[k] then return false end
    end
    return true
end

function M:union(other)
    local result = M.new()

    -- for k in pairs(self) do result[k] = true end
    -- for k in pairs(other) do result[k] = true end

    -- add all elements from self
    for e, _ in pairs(self.elements) do
        result:add(e)
    end

    -- add all elements from other
    for e, _ in pairs(other.elements) do
        result:add(e)
    end

    return result
end

function M:intersection(other)
    local result = M.new()

    -- Add elements that are in both sets
    for e, _ in pairs(self.elements) do
        if other:contains(e) then
            result:add(e)
        end
    end

    return result
end

function M:difference(other)
    local result = M.new()

    -- Add elements that are in self but not in other
    for e, _ in pairs(self.elements) do
        if not other:contains(e) then
            result:add(e)
        end
    end

    return result
end

-- Symmetric Difference: (A \ B) ∪ (B \ A)
function M:symmetric_difference(other)
    return self:union(other):difference(self:intersection(other))
end

-- Check if this set is a subset of another set
function M:is_subset(other)
    -- return self:subset(other) and self:size() < other:size()
    local result = M.new()
    for e, _ in pairs(self.elements) do
        if not other:contains(e) then
            return false
        end
    end
    return true
end

-- Convert a set (back) into a list
function M.to_list(set)
    local list = {}
    for e, _ in pairs(set.elements) do
        table.insert(list, e)
    end
    table.sort(list)
    return list
end

-- Powerset set of all subsets
function M:power_set()
    local elements
    self:to_list()
    local n = #elements
    local power_set = M.new()

    -- 2^n subsets
    for i = 0, (2 ^ n) - 1 do
        local subset = {}

        -- Check each bit position
        for j = 0, n - 1 do
            -- If the jth bit is a set, include elements[j+1]
            if (i & (1 << j)) ~= 0 then
                table.insert(subset, elements[j + 1])
            end
        end
        -- Add this subset to the power set (as a string representation)
        power_set:add(table.concat(subset, ","))
    end

    return power_set
end

return M
