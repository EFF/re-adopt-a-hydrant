ObjectId = require('mongoose').Types.ObjectId

class AdoptionInteractor
    getUserAdoptions : (userId, callback) ->
        if userId instanceof String or typeof userId == 'string'
            userId = ObjectId.fromString(userId)

        Adoption = mongoose.connection.model 'Adoption'
        Adoption.find {'userId': userId}, callback

module.exports = new AdoptionInteractor()
