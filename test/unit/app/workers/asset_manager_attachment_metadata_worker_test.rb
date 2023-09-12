require "test_helper"

class AssetManagerAttachmentMetadataWorkerTest < ActiveSupport::TestCase
  extend Minitest::Spec::DSL

  describe AssetManagerAttachmentMetadataWorker do
    let(:file) { File.open(fixture_path.join("sample.rtf")) }
    let(:attachment) { FactoryBot.create(:file_attachment, file:) }
    let(:attachment_data) { attachment.attachment_data }
    let(:worker) { AssetManagerAttachmentMetadataWorker.new }

    it "calls AssetManager::AttachmentRedirectUrlUpdater" do
      AssetManager::AttachmentUpdater.expects(:call).with(
        attachment_data,
        access_limited: true,
        draft_status: true,
        link_header: true,
      )

      AssetManager::AttachmentDeleter.expects(:call).with(
        attachment_data,
      )

      worker.perform(attachment_data.id)
    end

    context "attachment data has missing assets" do
      it "does not call updater nor deleter" do
        attachment_data.use_non_legacy_endpoints = true
        attachment_data.save!

        AssetManager::AttachmentUpdater.expects(:call).never

        AssetManager::AttachmentDeleter.expects(:call).never

        worker.perform(attachment_data.id)
      end
    end
  end
end
