function onUpdate(elapsed)
    if (keyboardJustPressed("SPACE")) then
        runTimer("a")
    end
end

function onTimerCompleted(tag)
    trace("timer")
end