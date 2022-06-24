ALIVE_Cutscene_CharacterVoiceLine_Play = function(characterAgent, lineID, intensity, priority)
    local controller_voiceLineAnm = PlayAnimation(characterAgent, lineID);
    local controller_voiceLineSound = SoundPlay(lineID .. ".wav");
    
    ControllerSetContribution(controller_voiceLineAnm, intensity);
    ControllerSetPriority(controller_voiceLineAnm, priority);
    ControllerSetLooping(controller_voiceLineAnm, false);
    ControllerSetLooping(controller_voiceLineSound, false);
end