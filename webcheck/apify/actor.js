const Apify = require('apify');
const request = require('request-promise');

Apify.main(async () => {
    const input = await Apify.getInput();
    console.log('My input:');
    console.dir(input);

    try {
        const html = await request(input.url);

        const subResults = input.tokens.map(token => {
            return { token, result: html.includes(token) ? 'present' : 'missing' };
        });

        const result = subResults.find(r => !r.result) === undefined;

        const output = {
            // html,
            crawledAt: new Date(),
            url: input.url,
            subResults,
            result,
            src: 'https://github.com/mixalturek/small-scripts/tree/master/webcheck',
        };

        console.log('My output:');
        console.dir(output);
        await Apify.setValue('OUTPUT', output);

        if (!result) {
            // https://github.com/apify/actor-send-mail
            console.log('Notifying about finding by email...')
            await Apify.call('apify/send-mail', {
                to: input.email.to,
                cc: input.email.cc,
                subject: input.email.subject,
                text: JSON.stringify(output, null, 4),
            });
        }
    } catch(e) {
        const output = {
            crawledAt: new Date(),
            url: input.url,
            result: false,
            error: `An error occurred: ${e}`,
            src: 'https://github.com/mixalturek/small-scripts/tree/master/webcheck',
        };

        console.log('My output:');
        console.dir(output);
        await Apify.setValue('OUTPUT', output);

        console.log('Notifying about failure by email...');
        await Apify.call('apify/send-mail', {
            to: input.email.to,
            cc: input.email.cc,
            subject: input.email.subject,
            text: JSON.stringify(output, null, 4),
        });

        throw e;
    }
});