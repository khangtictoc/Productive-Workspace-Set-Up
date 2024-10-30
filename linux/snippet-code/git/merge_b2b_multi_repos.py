import subprocess
import os

def run_command(command):
    print(os.popen(command).read())

def clone_and_merge(repo_url, source_branch, target_branch):
    """Clone the repository and merge source_branch into target_branch."""
    # Clone the repository
    repo_name = repo_url.split('/')[-1].replace('.git', '')
    
    if os.path.exists(f"./{repo_name}"):
        run_command(f'rm -drf ./{repo_name}')
    run_command(f'git clone {repo_url}')
    os.chdir(f"./{repo_name}")

    # Merge
    run_command(f'git checkout -t origin/{source_branch}')
    run_command(f'git merge origin/{target_branch}')
    run_command(f'git push')

    # print(f"Successfully merged {source_branch} into {target_branch} in {repo_name}.")
    # run_command(f'cd ..')

if __name__ == "__main__":
    # production-build & non-production-build
    repo_url_lst_1 = [
        'https://bitbucket.org/mercatustech/bigy-aggregatorapi.git',
        'https://bitbucket.org/mercatustech/bigy-gatewayapi.git',
        'https://bitbucket.org/mercatustech/dxp-assetapi.git',
        'https://bitbucket.org/mercatustech/dxp-centralapi.git',  
        'https://bitbucket.org/mercatustech/dxp_central_list_api.git',
        'https://bitbucket.org/mercatustech/dxp-dataassembly.git',
        'https://bitbucket.org/mercatustech/distributedcaching-api.git'  ,
        'https://bitbucket.org/mercatustech/dxp-distributioncore.git',
        'https://bitbucket.org/mercatustech/dxp-rewardapi.git',
        'https://bitbucket.org/mercatustech/dxp-settingapi.git',
        'https://bitbucket.org/mercatustech/dxp-settingapi.git' ,
        'https://bitbucket.org/mercatustech/dxp-trackingapi-v2.git',
        'https://bitbucket.org/mercatustech/dxp-webhook.git' ,
    ]
    # bigy-production & non-production-build
    repo_url_lst_2 = [
        'https://bitbucket.org/mercatustech/dxp-attribute-api.git',
        'https://bitbucket.org/mercatustech/dxp-cartapi.git',
        'https://bitbucket.org/mercatustech/dxp-cmsapi.git',  
        'https://bitbucket.org/mercatustech/dxp-api-v2.git',
        'https://bitbucket.org/mercatustech/elastic_proxy_api.git',
        'https://bitbucket.org/mercatustech/dxp-identityapi.git' ,
        'https://bitbucket.org/mercatustech/dxp-tools.git' ,
        'https://bitbucket.org/mercatustech/dxp-offerapi.git' ,
        'https://bitbucket.org/mercatustech/dxp-orderapi.git' ,
        'https://bitbucket.org/mercatustech/dxp-productapi.git',
        'https://bitbucket.org/mercatustech/dxp-storeapi.git',
        'https://bitbucket.org/mercatustech/dxp-weeklyadapi.git',
    ]
    # bigy-production & bigy-staging-build
    repo_url_lst_3 = [
        'https://bitbucket.org/mercatustech/dxp_cms_admin.git' , 
        'https://bitbucket.org/mercatustech/dxp_cms_frontsite.git' ,
        'https://bitbucket.org/mercatustech/dxp-imagehandlerapi.git',
        'https://bitbucket.org/mercatustech/dxp-reportapi.git',
        'https://bitbucket.org/mercatustech/dxp-smartconnect-rs-ecom.git',
        'https://bitbucket.org/mercatustech/dxp_admin_core.git',
    ]
    repo_url = 'https://bitbucket.org/mercatustech/dxp_admin_core.git'  
    source_branch = 'non-production-build'                 
    target_branch = 'bigy-production'                 
    source_branch = 'non-production-build'                 
    target_branch = 'production-build'                 
    source_branch = 'bigy-staging-build'                 
    target_branch = 'bigy-production'                 

    try:
        clone_and_merge(repo_url, source_branch, target_branch)
    except Exception as e:
        print(e)
