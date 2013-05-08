mongoose = require 'mongoose'
ObjectId = mongoose.Types.ObjectId

class AdoptionInteractor
    getUserAdoptions : (userId, callback) ->
        if userId instanceof String or typeof userId == 'string'
            userId = ObjectId.fromString(userId)

        Adoption = mongoose.connection.model 'Adoption'
        Adoption.find {'userId': userId}, callback

    getByHydrantId: (id, callback) =>
        Adoption = mongoose.connection.model 'Adoption'
        Adoption.findOne {'hydrantId': id}, callback

    adoptHydrant: (userId, hydrantId, callback) =>
        Adoption = mongoose.connection.model 'Adoption'
        adoption = new Adoption()
        adoption.userId = userId
        adoption.hydrantId = hydrantId
        adoption.save callback

module.exports = new AdoptionInteractor()
