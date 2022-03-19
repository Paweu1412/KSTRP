function table.empty( a )
    if type( a ) ~= "table" then
        return false
    end
    
    return next(a) == nil
end