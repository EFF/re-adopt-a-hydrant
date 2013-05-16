mongoose = require 'mongoose'
ObjectId = mongoose.Types.ObjectId

class AdoptionInteractor
    constructor: () ->
        @Adoption = mongoose.model 'Adoption'

    getUserAdoptions : (userId, callback) ->
        if userId instanceof String or typeof userId == 'string'
            userId = ObjectId.fromString(userId)
        @Adoption.find {userId: userId}, callback

    getAdoptionByHydrantId: (id, callback) =>
        @Adoption.findOne {hydrantId: id}, callback

    adoptHydrant: (userId, hydrantId, callback) =>
        adoption = new @Adoption()
        adoption.userId = userId
        adoption.hydrantId = hydrantId
        adoption.save callback

module.exports = new AdoptionInteractor()
