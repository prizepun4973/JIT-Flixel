function onCreatePost()

    -- strums
    setStrumPosition(0, 67, 50)
    setStrumPosition(1, 179, 50)
    setStrumPosition(2, 289, 50)
    setStrumPosition(3, 401, 50)

    setStrumPosition(4, 732, 50)
    setStrumPosition(5, 844, 50)
    setStrumPosition(6, 956, 50)
    setStrumPosition(7, 1068, 50)

    -- opponent
    makeStrum(0, "arrowLEFT")
    makeStrum(1, "arrowDOWN")
    makeStrum(2, "arrowUP")
    makeStrum(3, "arrowRIGHT")

    -- player
    makeStrum(4, "arrowLEFT")
    makeStrum(5, "arrowDOWN")
    makeStrum(6, "arrowUP")
    makeStrum(7, "arrowRIGHT")
end

function onUpdatePost(elapsed)
    -- sync
    for i=0, 7 do

       -- position sync
       setProperty("PlayState_Strum"..i..".x", getPropertyFromGroup("strums", index, "x"))
       setProperty("PlayState_Strum"..i..".y", getPropertyFromGroup("strums", index, "y"))

       -- offest sync

       setProperty("PlayState_Strum"..index..".offset.x", getProperty("PlayState_Strum"..index..".width") / 2)
       setProperty("PlayState_Strum"..index..".offset.y", getProperty("PlayState_Strum"..index..".height") / 2)
    end

end

function makeStrum(index, defaultName)
    makeAnimatedLuaSprite("PlayState_Strum"..index, "NOTE_Assets", getPropertyFromGroup("strums", index, "x"), getPropertyFromGroup("strums", index, "y"))
    addAnimationByPrefix("PlayState_Strum"..index, "PlayState_Strum"..index.."static", defaultName)

    setProperty("PlayState_Strum"..index..".scale.x", 0.7)
    setProperty("PlayState_Strum"..index..".scale.y", 0.7)
    addLuaSprite("PlayState_Strum"..index)
end

function setStrumPosition(index, x, y)
    setPropertyFromGroup("strums", index, "x", x)
    setPropertyFromGroup("strums", index, "y", y)
end
