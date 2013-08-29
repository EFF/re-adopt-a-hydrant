mongoose = require 'mongoose'

schema =
    userId:
        type: mongoose.Schema.Types.ObjectId
        ref: 'User'
        required: true
        index: true
    hydrantId:
        type: String
        required: true
        index: true
        validate: [
            {
                validator: (id, done) ->
                    Adoption = mongoose.model 'Adoption'
                    Adoption.findOne {hydrantId: id}, (err, adoption) =>
                        if err or adoption
                            done false
                        else
                            done true

                msg: 'This hydrant has already been adopted.'
            }
        ]

AdoptionSchema = new mongoose.Schema schema

mongoose.model 'Adoption', AdoptionSchema
