import { FlowRouter } from "meteor/kadira:flow-router";
import React from 'react';

export default class Page_NotFound extends React.Component {
  render() {
    return (
      <div id="not-found" className="page--not_found">
        <div className="not-found-image">
          <img src={FlowRouter.url("/img/404.svg")} alt="" />
        </div>
        <div className="not-found-title">
          <h1>Sorry, that page doesn't exist</h1>
          <a href={FlowRouter.url("/")} className="gotohomepage">Go to home</a>
        </div>
      </div>
    );
  }
}
