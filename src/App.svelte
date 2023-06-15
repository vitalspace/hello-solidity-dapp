<script lang="ts">
  import { ethers } from "ethers";
  import LogginButton from "./componets/login.svelte";
  import pathContract from "./lib/constract.json";

  let isLoggedIn: boolean = false;
  let message: string = "Welcome, before continuing please log in.";
  let currentMesage: string;
  let newMessage: string;

  class App {
    networkId: number = 5777;
    constract_address: string = "0x294B6C88F3d7ea041FB37c3CAeCdb262a2BdF21D";

    constructor() {
      this.isLoggedIn();
    }

    loadweb3 = async () => {
      //@ts-ignore
      if (window.ethereum) {
        //@ts-ignore
        this.singer()
          .then(() => {
            this.isLoggedIn();
          })
          .catch(() => {
            message = "We couldn't get your data.";
          });
      }
    };

    async signer() {
      //@ts-ignore
      const provider = new ethers.BrowserProvider(window.ethereum);
      return provider.getSigner();
    }

    async isLoggedIn() {
      //@ts-ignore
      const account = await window.ethereum.request({
        method: "eth_accounts",
      });
      if (account.length > 0) {
        isLoggedIn = true;
        this.getContract();
        this.getMessage();
      } else {
        isLoggedIn = false;
      }
    }

    singOut = async () => {
      alert("We have no control over your metamask, please log out manually.");
    };

    async getMessage() {
      const contract = await this.getContract();
      const message = contract.getMessage();
      currentMesage = await message;
    }

    changeMessage = async () => {
      if (newMessage !== "" && newMessage !== undefined) {
        const contract = await this.getContract();
        //@ts-ignore
        contract
          .updateMessaje(newMessage)
          .then(async (transaction) => {
            const receipt = await transaction.wait();
            if (receipt) {
              this.getMessage();
              newMessage = "";
            }
          })
          .catch((err) => {
            alert("There was a problem with the transaction.");
          });
      } else {
        alert("Please fill all data.");
      }
    };

    async getContract() {
      const contract = new ethers.Contract(
        this.constract_address,
        pathContract,
        await this.signer()
      );
      return contract;
    }
  }

  const app = new App();
</script>

<div class="flex items-center justify-center h-screen bg-[#5771B9] text-white">
  <div
    class="border p-4 bg-[#838AAC] rounded-md w-full sm:w-1/3 sm:h-auto md:w-1/2 md:h-auto"
  >
    <h1 class="text-4xl my-4 text-center">
      Hello world <span class="text-pink-300">Dapp</span>
    </h1>

    {#if isLoggedIn}
      <div class="py-8 border-2 my-2 text-center">
        <p class="py-2 text-2xl">
          Current Message: <span class="text-pink-300">{currentMesage}</span>
        </p>

        <input
          bind:value={newMessage}
          type="text"
          name=""
          id=""
          class="text-gray-700 w-4/5 sm:w-1/2 text-center py-2"
          placeholder="change messaje"
        />
        <br />
        <button
          class="py-2 bg-green-300 w-1/2 my-2 hover:bg-green-400 transition-all"
          on:click={app.changeMessage}>Submit</button
        >
      </div>
      <LogginButton app={app.singOut} message={"Sing out"} />
    {:else}
      <div
        class="py-8 border-2 my-2
    "
      >
        <p class="text-center">{message}</p>
      </div>
      <LogginButton app={app.loadweb3} message={false} />
    {/if}
  </div>
</div>
