<?php

namespace Training\Test\Controller\Index;

use \Magento\Framework\App\Action\Action;
use \Magento\Framework\App\Action\Context;

class Index2 extends Action
{
    protected $logger;
    
    public function __construct(
        Context $context,
        \Psr\Log\LoggerInterface $logger
    ) {
        parent::__construct($context);
        $this->logger = $logger;
    }

    public function execute()
    {
        $this->logger->addInfo('ZZZZ');
        $this->_forward('view', 'product', 'catalog', ['id' => 500]);
    }
}
