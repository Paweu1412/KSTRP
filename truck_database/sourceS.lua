local connectedDatabase = false

if not connectedDatabase then
    connectedDatabase = dbConnect("mysql", "dbname=" ..databaseConfig.dbName.. ";host=" ..databaseConfig.host.. ";charset=utf8", databaseConfig.user, databaseConfig.password, "share=0")

    if connectedDatabase == false then
        setServerPassword(exports.truck_util:generateString(16))

        for index, player in pairs(getElementsByType("player")) do
            kickPlayer(player, "system", "Wystąpił błąd bazy danych, skontaktuj się z administratorem")
        end

        return
    end

    setServerPassword()
    outputDebugString("Baza danych została pomyślnie połączona!", 4, 0, 255, 0)
end

function getDatabaseConnection()
    return connectedDatabase
end

function dbQueryExtended(query)
    if not query or not connectedDatabase then return end

    local finalResult = nil

    local preparedString = dbPrepareString(connectedDatabase, query)
    
    if preparedString then
        local queryHandle = dbQuery(connectedDatabase, preparedString)

        if queryHandle then
            pollProgress = dbPoll(queryHandle, -1)

            if not pollProgress then
                dbFree(queryHandle)
                return finalResult
            end

            if table.maxn(pollProgress) == 1 then
                pollProgress = pollProgress[1]
            end

            finalResult = pollProgress
            return finalResult
        end
    end
end

function dbExecExtended(query)
    if not query or not connectedDatabase then return end

    local preparedString = dbPrepareString(connectedDatabase, query)

    if preparedString then 
        if dbExec(connectedDatabase, preparedString) then
            return true
        else
            return false
        end
    end
end