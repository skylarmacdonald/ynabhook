# ynabhook
A YNAB webhook for Monzo, using the new API.

It's not the most beautiful code in the world, but it works.

## Usage

YNABHook is written using [Sinatra](https://sinatrarb.com) and [Unicorn](https://bogomips.org/unicorn/). Unicorn uses a socket so I can proxy it through [nginx](https://nginx.org/). There's a great guide [here on the Sinatra Recipes site](recipes.sinatrarb.com/p/deployment/nginx_proxied_to_unicorn) about how you can do this.

For this webhook to work, you need to set the following environment variables:

| Environment Variable | Contains                                                |
| -------------------- | --------                                                |
| `YNAB_KEY`           | Auth token for YNAB API. (OAuth isn't supported yet.)   |
| `BUDGET_ID`          | The ID of the budget your Monzo account is attached to. |
| `MONZO_ACCOUNT_ID`   | The YNAB ID that corresponds to your Monzo account.     |

Once you've got it set up, you'll need to register your public YNABHook URL (which will be whatever domain you run this from, with `/monzo` at the end) as a webhook on your Monzo account. You can do this from the [Monzo Developers website](https://developers.monzo.com).

## Security

This lump of code is not particularly secure on its own. Securing it is left as an exercise for the reader (which is to say, I was too lazy to do it in Sinatra).

What I recommend you do as a bare minimum is set it up using a SSL certificate (possibly from the likes of [Let's Encrypt](https://letsencrypt.org)) and use something like HTTP basic authentication in your nginx configuration.

You can probably come up with a better way of doing it. (I'm happy to accept PRs on this section of the README. And indeed the rest of the repository.)

## Licence

This code is provided under the MIT licence. The software and gems it depends on may have different licence terms; please check before installing or distributing.

&copy; 2018 [Skylar MacDonald](https://skylarmacdonald.com)
