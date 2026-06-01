//=============================================================================
// EXPLOSION SHADER GUI
// Custom editor for the Enhanced Explosion Shader
// Part of the Coloso Class VFX Package
//=============================================================================

using UnityEngine;
using UnityEditor;
using System.Linq;

public class ExplosionShaderGUI : ShaderGUI
{
    //---------------------------------------------------------------------
    // PROPERTY FOLDOUT STATES
    //---------------------------------------------------------------------
    private bool showRenderingOptions = true;
    private bool showBaseTextures = true;
    private bool showVertexAnimation = true;
    private bool showDissolveControls = true;
    private bool showFireControls = true;
    private bool showSmokeControls = true;
    private bool showAdvancedOptions = false;

    //---------------------------------------------------------------------
    // MAIN GUI METHOD
    //---------------------------------------------------------------------
    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
    {
        Material targetMat = materialEditor.target as Material;
        
        EditorGUILayout.BeginVertical(EditorStyles.helpBox);
        GUILayout.Space(10);
        EditorGUILayout.LabelField("Enhanced Explosion Shader", EditorStyles.boldLabel);
        GUILayout.Space(5);
        EditorGUILayout.LabelField("Thank you for joining the Coloso Class!");
        GUILayout.Space(10);
        EditorGUILayout.EndVertical();
        
        GUILayout.Space(10);
        
        //---------------------------------------------------------------------
        // RENDERING OPTIONS SECTION
        //---------------------------------------------------------------------
        showRenderingOptions = EditorGUILayout.Foldout(showRenderingOptions, "Rendering Options", true, EditorStyles.foldoutHeader);
        
        if (showRenderingOptions)
        {
            EditorGUI.indentLevel++;
            MaterialProperty cullMode = FindProperty("_CullMode", properties);
            materialEditor.ShaderProperty(cullMode, cullMode.displayName);
            EditorGUI.indentLevel--;
        }
        
        GUILayout.Space(5);
        
        //---------------------------------------------------------------------
        // BASE TEXTURES SECTION
        //---------------------------------------------------------------------
        showBaseTextures = EditorGUILayout.Foldout(showBaseTextures, "Base Textures", true, EditorStyles.foldoutHeader);
        
        if (showBaseTextures)
        {
            EditorGUI.indentLevel++;
            
            MaterialProperty mainTex = FindProperty("_MainTex", properties);
            materialEditor.TexturePropertySingleLine(
                new GUIContent(mainTex.displayName, "Main color and alpha texture"),
                mainTex);
            
            MaterialProperty noiseTex = FindProperty("_NoiseTex", properties);
            materialEditor.TexturePropertySingleLine(
                new GUIContent(noiseTex.displayName, "Noise texture for distortion and randomization"),
                noiseTex);
            
            MaterialProperty dissolveMap = FindProperty("_DissolveMap", properties);
            materialEditor.TexturePropertySingleLine(
                new GUIContent(dissolveMap.displayName, "Pattern used for the dissolve effect"),
                dissolveMap);
            
            EditorGUI.indentLevel--;
        }
        
        GUILayout.Space(5);
        
        //---------------------------------------------------------------------
        // VERTEX ANIMATION SECTION
        //---------------------------------------------------------------------
        showVertexAnimation = EditorGUILayout.Foldout(showVertexAnimation, "Vertex Animation", true, EditorStyles.foldoutHeader);
        
        if (showVertexAnimation)
        {
            EditorGUI.indentLevel++;
            
            MaterialProperty offsetCurve = FindProperty("_OffsetCurve", properties);
            materialEditor.ShaderProperty(offsetCurve, new GUIContent(offsetCurve.displayName, "Animation curve type for vertex displacement"));
            
            MaterialProperty offsetAmount = FindProperty("_OffsetAmount", properties);
            materialEditor.ShaderProperty(offsetAmount, new GUIContent(offsetAmount.displayName, "Maximum vertex displacement amount"));
            
            MaterialProperty offsetSpeed = FindProperty("_OffsetSpeed", properties);
            materialEditor.ShaderProperty(offsetSpeed, new GUIContent(offsetSpeed.displayName, "Speed of the vertex animation"));
            
            EditorGUI.indentLevel--;
        }
        
        GUILayout.Space(5);
        
        //---------------------------------------------------------------------
        // DISSOLVE CONTROLS SECTION
        //---------------------------------------------------------------------
        showDissolveControls = EditorGUILayout.Foldout(showDissolveControls, "Dissolve Controls", true, EditorStyles.foldoutHeader);
        
        if (showDissolveControls)
        {
            EditorGUI.indentLevel++;
            
            MaterialProperty dissolveSmoothing = FindProperty("_DissolveSmoothing", properties);
            materialEditor.ShaderProperty(dissolveSmoothing, new GUIContent(dissolveSmoothing.displayName, "Smoothness of the dissolve edge"));
            
            MaterialProperty edgeSharpness = FindProperty("_EdgeSharpness", properties);
            materialEditor.ShaderProperty(edgeSharpness, new GUIContent(edgeSharpness.displayName, "Sharpness of effect edges"));
            
            MaterialProperty dissolveNoiseAmount = FindProperty("_DissolveNoiseAmount", properties);
            materialEditor.ShaderProperty(dissolveNoiseAmount, new GUIContent(dissolveNoiseAmount.displayName, "How much noise affects the dissolve pattern"));
            
            MaterialProperty dissolveNoiseScale = FindProperty("_DissolveNoiseScale", properties);
            materialEditor.ShaderProperty(dissolveNoiseScale, new GUIContent(dissolveNoiseScale.displayName, "Scale of the noise pattern for dissolve"));
            
            EditorGUILayout.Space(5);
            EditorGUILayout.LabelField("Dissolve Animation", EditorStyles.boldLabel);
            
            MaterialProperty dissolveFlowSpeed = FindProperty("_DissolveFlowSpeed", properties);
            materialEditor.ShaderProperty(dissolveFlowSpeed, new GUIContent(dissolveFlowSpeed.displayName, "Speed of the dissolve animation"));
            
            MaterialProperty dissolveFlowStrength = FindProperty("_DissolveFlowStrength", properties);
            materialEditor.ShaderProperty(dissolveFlowStrength, new GUIContent(dissolveFlowStrength.displayName, "Strength of the dissolve animation"));
            
            EditorGUI.indentLevel--;
        }
        
        GUILayout.Space(5);
        
        //---------------------------------------------------------------------
        // FIRE CONTROLS SECTION
        //---------------------------------------------------------------------
        showFireControls = EditorGUILayout.Foldout(showFireControls, "Fire Controls", true, EditorStyles.foldoutHeader);
        
        if (showFireControls)
        {
            EditorGUI.indentLevel++;
            
            MaterialProperty fireColor = FindProperty("_FireColor", properties);
            materialEditor.ShaderProperty(fireColor, new GUIContent(fireColor.displayName, "HDR color of the fire effect"));
            
            MaterialProperty fireWidth = FindProperty("_FireWidth", properties);
            materialEditor.ShaderProperty(fireWidth, new GUIContent(fireWidth.displayName, "Width of the fire effect"));
            
            EditorGUI.indentLevel--;
        }
        
        GUILayout.Space(5);
        
        //---------------------------------------------------------------------
        // SMOKE CONTROLS SECTION
        //---------------------------------------------------------------------
        showSmokeControls = EditorGUILayout.Foldout(showSmokeControls, "Smoke Controls", true, EditorStyles.foldoutHeader);
        
        if (showSmokeControls)
        {
            EditorGUI.indentLevel++;
            
            MaterialProperty smokeColor = FindProperty("_SmokeColor", properties);
            materialEditor.ShaderProperty(smokeColor, new GUIContent(smokeColor.displayName, "HDR color of the smoke effect"));
            
            MaterialProperty smokeWidth = FindProperty("_SmokeWidth", properties);
            materialEditor.ShaderProperty(smokeWidth, new GUIContent(smokeWidth.displayName, "Width of the smoke effect"));
            
            MaterialProperty smokeOffset = FindProperty("_SmokeOffset", properties);
            materialEditor.ShaderProperty(smokeOffset, new GUIContent(smokeOffset.displayName, "Time offset between fire and smoke"));
            
            MaterialProperty smokeIntensity = FindProperty("_SmokeIntensity", properties);
            materialEditor.ShaderProperty(smokeIntensity, new GUIContent(smokeIntensity.displayName, "Overall intensity of the smoke effect"));
            
            EditorGUILayout.Space(5);
            EditorGUILayout.LabelField("Smoke Detail Settings", EditorStyles.boldLabel);
            
            MaterialProperty smokeNoiseInfluence = FindProperty("_SmokeNoiseInfluence", properties);
            materialEditor.ShaderProperty(smokeNoiseInfluence, new GUIContent(smokeNoiseInfluence.displayName, "How much noise affects the smoke"));
            
            MaterialProperty smokeDistortion = FindProperty("_SmokeDistortion", properties);
            materialEditor.ShaderProperty(smokeDistortion, new GUIContent(smokeDistortion.displayName, "Distortion amount for the smoke"));
            
            MaterialProperty smokeDarkEdge = FindProperty("_SmokeDarkEdge", properties);
            materialEditor.ShaderProperty(smokeDarkEdge, new GUIContent(smokeDarkEdge.displayName, "Darkening amount at smoke edges"));
            
            EditorGUI.indentLevel--;
        }
        
        GUILayout.Space(5);
        
        //---------------------------------------------------------------------
        // ADVANCED OPTIONS SECTION
        //---------------------------------------------------------------------
        showAdvancedOptions = EditorGUILayout.Foldout(showAdvancedOptions, "Advanced Options", true, EditorStyles.foldoutHeader);

        if (showAdvancedOptions)
        {
            EditorGUI.indentLevel++;
            
            EditorGUILayout.HelpBox("These settings should be used only when fine-tuning the effect.", MessageType.Info);
            
            // Filter and display any remaining properties not explicitly handled above
            MaterialProperty[] remainingProps = properties.Where(prop => 
                prop.name != "_MainTex" && prop.name != "_NoiseTex" && prop.name != "_DissolveMap" &&
                prop.name != "_CullMode" && prop.name != "_OffsetCurve" && prop.name != "_OffsetAmount" && prop.name != "_OffsetSpeed" &&
                prop.name != "_DissolveSmoothing" && prop.name != "_EdgeSharpness" && prop.name != "_DissolveNoiseAmount" && prop.name != "_DissolveNoiseScale" &&
                prop.name != "_DissolveFlowSpeed" && prop.name != "_DissolveFlowStrength" &&
                prop.name != "_FireColor" && prop.name != "_FireWidth" &&
                prop.name != "_SmokeColor" && prop.name != "_SmokeWidth" && prop.name != "_SmokeOffset" && prop.name != "_SmokeIntensity" &&
                prop.name != "_SmokeNoiseInfluence" && prop.name != "_SmokeDistortion" && prop.name != "_SmokeDarkEdge"
            ).ToArray();

            foreach (var prop in remainingProps)
            {
                materialEditor.ShaderProperty(prop, prop.displayName);
            }
            
            EditorGUI.indentLevel--;
        }
        
        GUILayout.Space(15);
        
        //---------------------------------------------------------------------
        // FOOTER SECTION
        //---------------------------------------------------------------------
        EditorGUILayout.BeginVertical(EditorStyles.helpBox);
        GUILayout.Space(5);
        EditorGUILayout.LabelField("Enhanced Explosion Shader v1.0", EditorStyles.centeredGreyMiniLabel);
        GUILayout.Space(5);
        EditorGUILayout.EndVertical();
    }
}