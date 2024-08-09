$env:KUBECONFIG="$HOME/.kube/uburtx.yaml"

$COMFYPOD = "comfyui-55f55bc94c-zqzgr"

kubectl cp .\comfyui_pvpre.sh ${COMFYPOD}:/tmp/comfyui_pvpre.sh
#kubectl exec $COMFYPOD -- bash -c '"`cat /tmp/comfyui_pvpre.sh`"'
kubectl exec $COMFYPOD -- bash -c '\
dirs=(checkpoints clip clip_vision configs controlnet diffusers embeddings gligen hypernetworks loras style_models unet upscale_models vae vae_approx)
for dir in "${dirs[@]}"
do
    mkdir -p ~/comfyui-models/$dir
    touch ~/comfyui-models/$dir/put_here
done
'

#SD3
$modeldir = "C:\temp\models\stablediffusion3\"

#models
foreach ($dir in $(Get-ChildItem -Path $modeldir -Directory))
{
    foreach ($model in $(Get-ChildItem -Path $dir.FullName -File))
    {
       kubectl cp $($model.FullName.Replace('C:\','.\')) ${COMFYPOD}:/root/comfyui-models/$($dir.Name)/$($model.Name)
    }
}