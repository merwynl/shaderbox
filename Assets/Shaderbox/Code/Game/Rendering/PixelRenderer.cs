using UnityEngine;

[ExecuteAlways]
public class PixelRenderer
{
    [SerializeField] private RenderTexture _mainRenderTexture;

    private void Update()
    {
        Shader.SetGlobalTexture("_mainRenderTexture", _mainRenderTexture);    
    }
    
}
