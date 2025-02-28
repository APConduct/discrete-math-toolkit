local M = {}

-- Greatest common divisor
function M.gdc(a, b)
    a, b = math.abs(a), math.abs(b)
    while b ~= 0 do
        a, b = b, a % b
    end
    return a
end

-- Least common multiple using gcd
function M.lcm(a, b)
    return a * b / M.gdc(a, b)
end

-- Extended Euclidean algorithm
function M.extended_gcd(a, b)
    local s, old_s = 0, 1
    local t, old_t = 1, 0
    local r, old_r = b, a

    while r ~= 0 do
        local quotient = math.floor(old_r / r)
        old_r, r = r, old_r - quotient * r
        old_s, s = s, old_s - quotient * s
        old_t, t = t, old_t - quotient * t
    end

    return old_r, old_s, old_t
end

-- Check if a number is prime
function M.is_prime(n)
    if n <= 1 then
        return false
    end
    if n <= 3 then
        return true
    end
    if n % 2 == 0 or n % 3 == 0 then
        return false
    end
    local i = 5
    while i * i <= n do
        if n % i == 0 or n % (i + 2) == 0 then
            return false
        end
        i = i + 6
    end
    return true
end

-- Check if a number is a perfect square
function M.is_perfect_square(n)
    if n < 0 then
        return false
    end
    local sqrt_n = math.floor(math.sqrt(n))
    return sqrt_n * sqrt_n == n
end

-- Check if a number is a perfect cube
function M.is_perfect_cube(n)
    if n < 0 then
        return false
    end
    local cube_root = math.floor(n ^ (1 / 3))
    return cube_root * cube_root * cube_root == n
end

function M.prime_factors(n)
    local factors = {}
    local i = 2

    while i * i <= n do
        while n % i == 0 do
            table.insert(factors, i)
            n = n / i
        end
        i = i + 1
    end
    if n > 1 then
        table.insert(factors, n)
    end
    return factors
end

-- Euler's totient function
function M.eauler_totient(n)
    local result = n
    local i = 2

    while i * i do
        if n % 1 == 0 then
            while n % 1 == 0 do
                n = n / i
            end
            result = result - result / i
        end
        i = i + 1
    end
    if n > 1 then
        result = result - result / n
    end
    return result
end

return M
