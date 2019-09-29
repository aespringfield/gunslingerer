require 'rails_helper'
require 'credly_badge_service'

describe CredlyBadgeService do
    describe '::get_badge_templates' do
        it 'makes the correct request without query params' do
            stub_request(:get, 'https://sandbox-api.youracclaim.com/v1/organizations/123-abc/badge_templates')
                .with(
                    headers: {
                        'Accept'=>'*/*',
                        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                        'Authorization'=>'NTU1LWVlZQ=='
                    }
                )
                .to_return(status: 200, body: badge_templates_stub_body, headers: {})


            templates = CredlyBadgeService::get_badge_templates(
                organization_id: '123-abc',
                auth_token: '555-eee'
            )
            expect(templates).to eq JSON.parse(badge_templates_stub_body)
        end

        it 'makes the correct request with query params' do
            stub_request(:get, 'https://sandbox-api.youracclaim.com/v1/organizations/123-abc/badge_templates?filter=public&sort=name&page=3')
                .with(
                    headers: {
                        'Accept'=>'*/*',
                        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                        'Authorization'=>'NTU1LWVlZQ=='
                    }
                )
                .to_return(status: 200, body: badge_templates_stub_body, headers: {})


            templates = CredlyBadgeService::get_badge_templates(
                organization_id: '123-abc',
                auth_token: '555-eee',
                filter: 'public',
                sort: 'name',
                page: 3
            )
            expect(templates).to eq JSON.parse(badge_templates_stub_body)
        end
    end

    describe '::post_badges' do
        it 'makes the correct request without optional fields' do
            stub_request(:post, 'https://sandbox-api.youracclaim.com/v1/organizations/123-abc/badges')
            .with(
                headers: {
                    'Accept'=>'*/*',
                    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                    'Authorization'=>'NTU1LWVlZQ=='
                }
                body: ''
            )
            .to_return(status: 200, body: badge_templates_stub_body, headers: {})
        end
    end
end

def badge_templates_stub_body
    '{"data":[{"id":"72558f4b-51f0-486a-855f-5a8937397592","allow_duplicate_badges":false,"cost":null,"description":"test","global_activity_url":"http://test.com","level":null,"name":"Anna1","state":"active","public":true,"badges_count":0,"recipient_type":"User","show_badge_lmi":false,"show_lmi_jobs":false,"show_skill_tag_links":true,"vanity_slug":"anna1","record_to_blockchain":null,"time_to_earn":null,"type_category":null,"printing_disabled":false,"criteria_url_name":null,"criteria_url":null,"certification":true,"state_updated_at":null,"created_at":"2019-09-28T13:42:12.773Z","updated_at":"2019-09-28T13:42:12.809Z","template_type":null,"show_template_settings":false,"get_issue_count":0,"image":{"id":"956bb399-c105-4a14-81f2-b81ac50572cd","url":"https://sandbox-images.youracclaim.com/images/956bb399-c105-4a14-81f2-b81ac50572cd/blob.png"},"image_url":"https://sandbox-images.youracclaim.com/images/956bb399-c105-4a14-81f2-b81ac50572cd/blob.png","url":"https://sandbox.youracclaim.com/org/anna/badge/anna1","owner":{"type":"Organization","id":"41aa46aa-93ed-4603-9a91-55e2cfc8f6b7","name":"Anna","enable_blockchain":null,"url":"https://sandbox-api.youracclaim.com/v1/organizations/41aa46aa-93ed-4603-9a91-55e2cfc8f6b7","vanity_url":"https://sandbox.youracclaim.com/org/anna","vanity_slug":"anna","verified":false,"viewable":true},"alignments":[],"recommendations":[],"required_badge_templates":[],"badge_template_activities":[{"id":"93ceedfe-4468-45e7-a857-1496a0c2773a","title":"test","activity_type":"Application","activity_url":"http://test.com","required_badge_template_id":null}],"skills":["Ruby"],"reporting_tags":[]},{"id":"28e76885-6f25-496e-b12b-49e4bda2d71f","allow_duplicate_badges":false,"cost":null,"description":"test","global_activity_url":"http://test.com","level":null,"name":"Anna2","state":"active","public":true,"badges_count":0,"recipient_type":"User","show_badge_lmi":false,"show_lmi_jobs":false,"show_skill_tag_links":true,"vanity_slug":"anna2","record_to_blockchain":null,"time_to_earn":null,"type_category":null,"printing_disabled":false,"criteria_url_name":null,"criteria_url":null,"certification":true,"state_updated_at":null,"created_at":"2019-09-28T13:42:15.801Z","updated_at":"2019-09-28T13:42:48.139Z","template_type":null,"show_template_settings":false,"get_issue_count":0,"image":{"id":"708cf4ad-afaf-4351-be6e-60d4c5d81f52","url":"https://sandbox-images.youracclaim.com/images/708cf4ad-afaf-4351-be6e-60d4c5d81f52/blob.png"},"image_url":"https://sandbox-images.youracclaim.com/images/708cf4ad-afaf-4351-be6e-60d4c5d81f52/blob.png","url":"https://sandbox.youracclaim.com/org/anna/badge/anna2","owner":{"type":"Organization","id":"41aa46aa-93ed-4603-9a91-55e2cfc8f6b7","name":"Anna","enable_blockchain":null,"url":"https://sandbox-api.youracclaim.com/v1/organizations/41aa46aa-93ed-4603-9a91-55e2cfc8f6b7","vanity_url":"https://sandbox.youracclaim.com/org/anna","vanity_slug":"anna","verified":false,"viewable":true},"alignments":[],"recommendations":[],"required_badge_templates":[],"badge_template_activities":[{"id":"82e92bd8-4759-47f2-addd-7182220a535f","title":"test","activity_type":"Application","activity_url":"http://test.com","required_badge_template_id":null}],"skills":["Ruby"],"reporting_tags":[]}],"metadata":{"count":2,"current_page":1,"total_count":2,"total_pages":1,"per":50,"previous_page_url":null,"next_page_url":null}}'
end
