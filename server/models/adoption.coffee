mongoose = require 'mongoose'
timestamp = require 'mongoose-troop/lib/timestamp'

schema = 
    userId : 
        type: mongoose.Schema.Types.ObjectId
        ref : 'User'
        required: true
        index: true
    hydrantId :
        type : String
        required: true

AdoptionSchema = new mongoose.Schema schema

AdoptionSchema.plugin timestamp , {useVirtual: false}

mongoose.model 'Adoption', AdoptionSchema
