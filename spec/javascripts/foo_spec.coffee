describe "Foo", ->
    describe "with HTML fixture", ->
        beforeEach ->
            loadFixtures "fixture.html"
        it "the text should be added", ->
            expect($('#0')).toHaveText "foo"
