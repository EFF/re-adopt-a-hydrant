chai = require 'chai'
assert = chai.assert
sinon = require 'sinon'
mongoose = require 'mongoose'
ObjectId = mongoose.Types.ObjectId

describe 'interactors', () ->
    beforeEach () ->
        @objectId = new ObjectId()
        @objectIdAsString = @objectId.toString()
        
        @fakeModel = sinon.spy()
        @fakeModel.findById = sinon.stub().yields()
        @fakeModel.find = sinon.stub().yields()
        @fakeModel.findOne = sinon.stub().yields()
        @fakeModel.prototype.save = sinon.stub().yields()

        sinon.stub mongoose, 'model', () =>
            return @fakeModel

    afterEach () ->
            mongoose.model.restore()

    describe 'UserInteractor', () ->
        beforeEach () ->
            @userInteractor = require '../../server/interactors/user_interactor'

        it 'should get a user by id', () ->
            callback = sinon.spy()
            @userInteractor.getById @objectIdAsString, callback

            assert.isTrue callback.calledOnce, 'callback should be called'
            assert.isTrue @fakeModel.findById.calledOnce, 'findById should be called'
            assert.isTrue @fakeModel.findById.calledWith(@objectIdAsString, 'id username displayName name', callback), 'findById should be called with the right arguments'

    describe 'AdoptionInteractor', () ->
        beforeEach () ->
            @adoptionInteractor = require '../../server/interactors/adoption_interactor'

        it 'should getUserAdoptions', () ->
            callback = sinon.spy()
            @adoptionInteractor.getUserAdoptions @objectIdAsString, callback

            assert.isTrue callback.calledOnce, 'callback should be called'
            assert.isTrue @fakeModel.find.calledOnce, 'find should be called'
            assert.isTrue @fakeModel.find.calledWith({userId: @objectId}, callback), 'find should be called with the right arguments'

        it 'should getAdoptionByHydrantId', () ->
            callback = sinon.spy()
            @adoptionInteractor.getAdoptionByHydrantId @objectIdAsString, callback

            assert.isTrue callback.calledOnce, 'callback should be called'
            assert.isTrue @fakeModel.findOne.calledOnce, 'findOne should be called'
            assert.isTrue @fakeModel.findOne.calledWith({hydrantId: @objectIdAsString}, callback), 'findOne should be called with the right arguments'

        it 'should adoptHydrant', () ->
            callback = sinon.spy()
            @adoptionInteractor.adoptHydrant @objectIdAsString, @objectIdAsString, callback

            assert.isTrue callback.calledOnce, 'callback should be called'
            assert.isTrue @fakeModel.calledOnce, 'constructor should be called'
            assert.equal @fakeModel.prototype.save.firstCall.thisValue.userId, @objectIdAsString, 'adoption.userId should be set'
            assert.equal @fakeModel.prototype.save.firstCall.thisValue.hydrantId, @objectIdAsString, 'adoption.hydrantId should be set'
            assert.isTrue @fakeModel.prototype.save.calledOnce, 'should be called once'
            assert.isTrue @fakeModel.prototype.save.calledWith(callback), 'save should be called with the right arguments'

    describe 'HydrantInteractor', () ->
        beforeEach () ->
            @hydrantInteractor = require '../../server/interactors/hydrant_interactor'

        it 'should search'
        it 'should _createQuery'
        it 'should do something to refactor cause the code is shit to tests'
