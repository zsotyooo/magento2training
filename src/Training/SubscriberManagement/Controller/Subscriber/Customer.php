<?php

namespace Training\SubscriberManagement\Controller\Subscriber;

use Magento\Framework\Controller\Result\Json as JsonResult;
use Magento\Framework\Controller\Result\JsonFactory;
use Magento\Framework\Json\Helper\Data as JsonHelper;

class Customer extends AbstractSubscriberAction
{
    public function execute()
    {
        $api = $this->customerRepository;

        $searchCriteria = $this->searchCriteriaBuilder
            ->create();

        $result = [];
        foreach ($api->getList($searchCriteria)->getItems() as $item) {
            $result[$item->getId()] = [
                'email' => $item->getEmail(),
                'comment' => $item->getExtensionAttributes()->getSubscriberComment()->getComment()
            ];
        }

        $jsonResponse = $this->jsonResponse->create();
        $jsonResponse->setJsonData($this->jsonHelper->jsonEncode($result));
        return $jsonResponse;
    }
}
