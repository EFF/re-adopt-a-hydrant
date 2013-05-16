mongoose = require 'mongoose'
ObjectId = mongoose.Types.ObjectId

class AdoptionInteractor
    getUserAdoptions : (userId, callback) ->
        if userId instanceof String or typeof userId == 'string'
            userId = ObjectId.fromString(userId)

        Adoption = mongoose.model 'Adoption'
        Adoption.find {userId: userId}, callback

    getAdoptionByHydrantId: (id, callback) =>
        Adoption = mongoose.model 'Adoption'
        Adoption.findOne {hydrantId: id}, callback

    adoptHydrant: (userId, hydrantId, callback) =>
        Adoption = mongoose.model 'Adoption'
        adoption = new Adoption()
        adoption.userId = userId
        adoption.hydrantId = hydrantId
        adoption.save callback

module.exports = new AdoptionInteractor()
