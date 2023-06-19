// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    /*
     * Um pouco de mágica, use o Google para entender o que são eventos em Solidity!
     */
    event NewWave(address indexed from, uint256 timestamp, string message);

    /*
     * Crio um struct Wave.
     * Um struct é basicamente um tipo de dados customizado onde nós podemos customizar o que queremos armazenar dentro dele
     */
    struct Wave {
        address waver; // Endereço do usuário que deu tchauzinho
        string message; // Mensagem que o usuário envio
        uint256 timestamp; // Data/hora de quando o usuário tchauzinhou.
    }

    /*
     * Declara a variável waves que permite armazenar um array de structs.
     * Isto que me permite armazenar todos os tchauzinhos que qualquer um tenha me enviado!
     */
    Wave[] waves;

    constructor() payable{
        console.log("EU SOU UM CONTRATO INTELIGENTE. POG.");
    }

    /*
     * Você notará que eu mudei um pouco a função de tchauzinho e agora requer uma string chamada _message. Esta é a mensagem que o nosso usuário enviou pelo frontend!
     */
    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s tchauzinhou com a mensagem %s", msg.sender, _message);

        /*
         * Aqui é onde eu efetivamenet armazeno o tchauzinho no array.
         */
        waves.push(Wave(msg.sender, _message, block.timestamp));

        /*
         * Eu adicionei algo novo aqui. Use o Google para tentar entender o que é e depois me conte o que aprendeu em #general-chill-chat
         */
        emit NewWave(msg.sender, block.timestamp, _message);

        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance,
            "Tentando sacar mais dinheiro que o contrato possui."
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Falhou em sacar dinheiro do contrato.");
    }

    /*
     * Adicionei uma função getAllWaves que retornará os tchauzinhos.
     * Isso permitirá recuperar os tchauzinhos a partir do nosso site!
     */
    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        // Opcional: Adicione esta linha se você quer ver o contrato imprimir o valor!
        // Também imprimirá em run.js.
        console.log("Temos %d tchauzinhos no total!", totalWaves);
        return totalWaves;
    }
}
