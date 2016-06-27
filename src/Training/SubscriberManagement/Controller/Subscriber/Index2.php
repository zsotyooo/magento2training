<?php

namespace Training\SubscriberManagement\Controller\Subscriber;

use Magento\Framework\Controller\Result\Json as JsonResult;
use Magento\Framework\Controller\Result\JsonFactory;
use Magento\Framework\Json\Helper\Data as JsonHelper;

class Index2 extends AbstractSubscriberAction
{
    public function execute()
    {
        $api = $this->subscriberRepositoryFactory->create();

        $sortOrder = $this->sortOrderBuilder
            ->setField('entity_id')
            ->setDescendingDirection()
            ->create();

        $searchCriteria = $this->searchCriteriaBuilder
            ->addFilter('entity_id', 15, 'lt')
            ->addSortOrder($sortOrder)
            ->setPageSize(10)
            ->create();

        $result = [];
        foreach ($api->getList($searchCriteria)->getItems() as $item) {
            $result[$item->getId()] = $item->getData();
        }

        $jsonResponse = $this->jsonResponse->create();
        $jsonResponse->setJsonData($this->jsonHelper->jsonEncode($result));
        return $jsonResponse;
    }
}
